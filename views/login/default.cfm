<div class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="LoginModalLabel" aria-hidden="true" id="LoginModal">
	<div class="modal-header">
		<h3 id="LoginModalLabel">Please login</h3>
	</div>
	<div class="modal-body">
		<cfoutput>
			<form class="form with-margin" name="login-form" id="login-form" method="post" action="#CGI.scriptname#?#CGI.querystring#">
				<input type="hidden" name="a" id="a" value="">
				<cfif IsDefined("SESSION.Login_Message")>
					<p class="text-error">#SESSION.Login_Message#</p>
				</cfif>
				<cfif IsDefined("form.recovery_email")>
				<p class="text-error">A temporary password has been sent to your email account. Please check your email and log in with your temporary password.</p>
				</cfif>
				<p>
					<label for="jusername"><span class="big">Email</span></label>
					<input type="text" name="jusername" id="jusername" class="full-width" value="">
				</p>
				<p>
					<label for="jpassword"><span class="big">Password</span></label>
					<input type="password" name="jpassword" id="jpassword" class="full-width" value="">
				</p>
				<button type="submit" class="btn">Login</button>
				<hr>
				<p>
					<label class="checkbox">
				      <input type="checkbox" name="rememberUser" id="rememberUser" value="1">Keep me logged in
				    </label>
				</p>
			</form>
		</cfoutput>
	</div>
	<div class="modal-footer">
		<form class="form" id="password-recovery" method="post" action="<cfoutput>#CGI.scriptname#?#CGI.querystring#</cfoutput>">
				<legend>
				<span class="text-info">
				Lost password?
				</span>
				</legend>
				<p>
					<label for="recovery_email">Enter your e-mail address</label>
					<input type="text" name="recovery_email" id="recovery_email" value="">
					<br><button type="button" class="btn">Send</button>
				</p>
		</form>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$('#LoginModal').modal('show');
});
</script>