Return-Path: <linux-hyperv+bounces-2667-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4819945B96
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0773328303F
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D41DB446;
	Fri,  2 Aug 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JV28x5pG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BB1DB449;
	Fri,  2 Aug 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592552; cv=none; b=pI07baPm2mzkM3rOnVELWBTH24oUaDqFuH/fOY6AugqNf/AD06zP7UsW+VkfG9jnlzsRaDi+zQJroey6jorei4ync1H7Brzr0Axr49rU3dAdSWZoV8S8ENNNQlMukRJ5UmZ5G0nd56b7z9y8FQyk5FOi0WlwNet1Hcnv+UZangM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592552; c=relaxed/simple;
	bh=gfsrsy9aeFqAqU9yWbURrKdcmZt8i2YdtBvOr4UTBCc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSMvBBGLXAzSb4TQb45xa56Po/S/7GrhaYjJjd3wJxnOpVYqcujbKxe/26e6PQlxzpKdwTn6FwzRHDn28axldrZTTCh/GaaSL9m2fkwOVj7TU+3qkN3AM5EJmcKaDf0rt3Mb9ugMDuuDm9YIDVUUhLqe6JsxYuPfuirPSAr8/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JV28x5pG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rtTDTw9Gni8KubcFPNZLhAg4nyhV2TlscOI77GxZyTg=; b=JV28x5pGsjRxLlL/zVBlfnvKtx
	fTIMVj8qf33X5hc+bSXRB/4RHHpH3Bfjn2TTWjqjg3l2DkxsyyQXsChraUSjKDq0lrgq/Fr0Bfm1h
	ehRCygpSwJMkVYkMJDg4eq9wH9EkJTQ9+ApEL/plSZ8b5Fx8Jzc5xx+vpGUJ2hj/eaDuvVrS/oEtC
	YRDzGEE0aa8A59offfNmQTpOf3Lw51bISVfEN2L2cBfc27O7mqO9jZY1r2a2YLhmSHLT/EjVEdPyK
	C3HBABAHo3raY2l6Cn8YvGscSa0yFTirPcE3bib5rp8SzjRjCb07b8iFW2AKB205ONl8K7Hr9ZN0m
	Igod/B5Q==;
Received: from [2001:8b0:10b:5:9c27:6796:c1af:9131] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZp0X-00000000sx2-49Ev;
	Fri, 02 Aug 2024 09:55:34 +0000
Message-ID: <e83f8294a27d8b76d0c65ab7c105b2d4b8a53474.camel@infradead.org>
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, lirongqing@baidu.com, 
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org,  decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com,  x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Aug 2024 10:55:33 +0100
In-Reply-To: <1508F48A-DCCF-4AF6-8CA3-109B289E98B2@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
	 <87ttg42uju.ffs@tglx>
	 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
	 <87ikwk2hcs.ffs@tglx>
	 <cf5bf4eec7cb36eec0b673353ff027bee853dd48.camel@infradead.org>
	 <87a5hw2euf.ffs@tglx>
	 <bb8c97ea2b3596f605b9e1b27a221a1c64727e59.camel@infradead.org>
	 <871q382b0v.ffs@tglx> <1508F48A-DCCF-4AF6-8CA3-109B289E98B2@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-5FxiMSjbSBwrghl1/Sjz"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-5FxiMSjbSBwrghl1/Sjz
Content-Type: multipart/mixed; boundary="=-/xP/5EMQood0nPv+fEDF"

--=-/xP/5EMQood0nPv+fEDF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-08-01 at 22:31 +0100, David Woodhouse wrote:
> On 1 August 2024 22:22:56 BST, Thomas Gleixner <tglx@linutronix.de> wrote=
:
> > On Thu, Aug 01 2024 at 21:49, David Woodhouse wrote:
> > > On Thu, 2024-08-01 at 22:00 +0200, Thomas Gleixner wrote:
> > > > > I justify my cowardice on the basis that it doesn't *matter* if a
> > > > > hardware implementation is still toggling the IRQ pin; in that ca=
se
> > > > > it's only a few irrelevant transistors which are busy, and it doe=
sn't
> > > > > translate to steal time.
> > > >=20
> > > > On real hardware it translates to power...
> > >=20
> > > Perhaps, although I'd guess it's a negligible amount. Still, happy to
> > > be brave and make it unconditional. Want a new version of the patch?
> >=20
> > Let'ss fix the shutdown sequence first (See Michaels latest mail) and
> > then do the clockevents_i8253_init() change on top.
>=20
> Makes sense.

On second thoughts, let's add clockevent_i8253_disable() first and call
it when the PIT isn't being used, then we can bikeshed the precise
behaviour of that function to our hearts' content.

I think it should look like this. Revised version of your test program
attached.

void clockevent_i8253_disable(void)
{
	raw_spin_lock(&i8253_lock);

	/*
	 * Writing the MODE register should stop the counter, according to
	 * the datasheet. This appears to work on real hardware (well, on
	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
	 * shed).
	 *
	 * However, some virtual implementations differ, and the MODE change
	 * doesn't have any effect until either the counter is written (KVM
	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
	 * it may not stop the *count*, only the interrupts. Although in
	 * the virt case, that probably doesn't matter, as the value of the
	 * counter will only be calculated on demand if the guest reads it;
	 * it's the interrupts which cause steal time.
	 *
	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
	 * firing repeatedly if the counter is running. But it *does* do the
	 * right thing when the MODE register is written.
	 *
	 * So: write the MODE and then load the counter, which ensures that
	 * the IRQ is stopped on those buggy virt implementations. And then
	 * write the MODE again, which is the right way to stop it.
	 */
	outb_p(0x30, PIT_MODE);
	outb_p(0, PIT_CH0);
	outb_p(0, PIT_CH0);

	outb_p(0x30, PIT_MODE);

	raw_spin_unlock(&i8253_lock);
}


--=-/xP/5EMQood0nPv+fEDF
Content-Disposition: attachment; filename="i8254.c"
Content-Transfer-Encoding: base64
Content-Type: text/x-csrc; name="i8254.c"; charset="UTF-8"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzeXMvaW8uaD4KCnR5cGVkZWYgdW5zaWdu
ZWQgY2hhcgl1aW50OF90Owp0eXBlZGVmIHVuc2lnbmVkIHNob3J0CXVpbnQxNl90OwoKI2RlZmlu
ZSBCVUlMRElPKGJ3bCwgYncsIHR5cGUpCQkJCQkJXApzdGF0aWMgX19hbHdheXNfaW5saW5lIHZv
aWQgX19vdXQjI2J3bCh0eXBlIHZhbHVlLCB1aW50MTZfdCBwb3J0KQlcCnsJCQkJCQkJCQlcCglh
c20gdm9sYXRpbGUoIm91dCIgI2J3bCAiICUiICNidyAiMCwgJXcxIgkJCVwKCQkgICAgIDogOiAi
YSIodmFsdWUpLCAiTmQiKHBvcnQpKTsJCQlcCn0JCQkJCQkJCQlcCgkJCQkJCQkJCVwKc3RhdGlj
IF9fYWx3YXlzX2lubGluZSB0eXBlIF9faW4jI2J3bCh1aW50MTZfdCBwb3J0KQkJCVwKewkJCQkJ
CQkJCVwKCXR5cGUgdmFsdWU7CQkJCQkJCVwKCWFzbSB2b2xhdGlsZSgiaW4iICNid2wgIiAldzEs
ICUiICNidyAiMCIJCQlcCgkJICAgICA6ICI9YSIodmFsdWUpIDogIk5kIihwb3J0KSk7CQkJXAoJ
cmV0dXJuIHZhbHVlOwkJCQkJCQlcCn0KCkJVSUxESU8oYiwgYiwgdWludDhfdCkKCiNkZWZpbmUg
aW5iIF9faW5iCiNkZWZpbmUgb3V0YiBfX291dGIKCiNkZWZpbmUgUElUX01PREUJMHg0MwojZGVm
aW5lIFBJVF9DSDAJCTB4NDAKI2RlZmluZSBQSVRfQ0gyCQkweDQyCgpzdGF0aWMgaW50IGlzODI1
NDsKCnN0YXRpYyB2b2lkIGR1bXBfcGl0KHZvaWQpCnsKCWlmIChpczgyNTQpIHsKCQkvLyBMYXRj
aCBhbmQgb3V0cHV0IGNvdW50ZXIgYW5kIHN0YXR1cwoJCW91dGIoMHhDMiwgUElUX01PREUpOwoJ
CXByaW50ZigiJTAyeCAlMDJ4ICUwMnhcbiIsIGluYihQSVRfQ0gwKSwgaW5iKFBJVF9DSDApLCBp
bmIoUElUX0NIMCkpOwoJfSBlbHNlIHsKCQkvLyBMYXRjaCBhbmQgb3V0cHV0IGNvdW50ZXIKCQlv
dXRiKDB4MCwgUElUX01PREUpOwoJCXByaW50ZigiJTAyeCAlMDJ4XG4iLCBpbmIoUElUX0NIMCks
IGluYihQSVRfQ0gwKSk7Cgl9Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyKiBhcmd2W10pCnsK
CWludCBucl9jb3VudHMgPSAyOwoKCWlmIChhcmdjID4gMSkKCQlucl9jb3VudHMgPSBhdG9pKGFy
Z3ZbMV0pOwoKCWlmIChhcmdjID4gMikKCQlpczgyNTQgPSAxOwoKCWlmIChpb3Blcm0oMHg0MCwg
NCwgMSkgIT0gMCkKCQlyZXR1cm4gMTsKCglkdW1wX3BpdCgpOwoKCXByaW50ZigiU2V0IG9uZXNo
b3RcbiIpOwoJb3V0YigweDM4LCBQSVRfTU9ERSk7CglvdXRiKDB4MDAsIFBJVF9DSDApOwoJb3V0
YigweDBGLCBQSVRfQ0gwKTsKCglkdW1wX3BpdCgpOwoJdXNsZWVwKDEwMDApOwoJZHVtcF9waXQo
KTsKCglwcmludGYoIlNldCBwZXJpb2RpY1xuIik7CglvdXRiKDB4MzQsIFBJVF9NT0RFKTsKCW91
dGIoMHgwMCwgUElUX0NIMCk7CglvdXRiKDB4MEYsIFBJVF9DSDApOwoKCWR1bXBfcGl0KCk7Cgl1
c2xlZXAoMTAwMCk7CglkdW1wX3BpdCgpOwoJZHVtcF9waXQoKTsKCXVzbGVlcCgxMDAwMDApOwoJ
ZHVtcF9waXQoKTsKCXVzbGVlcCgxMDAwMDApOwoJZHVtcF9waXQoKTsKCglwcmludGYoIlNldCBz
dG9wICglZCBjb3VudGVyIHdyaXRlcylcbiIsIG5yX2NvdW50cyk7CglvdXRiKDB4MzAsIFBJVF9N
T0RFKTsKCXdoaWxlIChucl9jb3VudHMtLSkKCQlvdXRiKDB4RkYsIFBJVF9DSDApOwoKCWR1bXBf
cGl0KCk7Cgl1c2xlZXAoMTAwMDAwKTsKCWR1bXBfcGl0KCk7Cgl1c2xlZXAoMTAwMDAwKTsKCWR1
bXBfcGl0KCk7CgoJcHJpbnRmKCJTZXQgTU9ERSAwXG4iKTsKCW91dGIoMHgzMCwgUElUX01PREUp
OwoKCWR1bXBfcGl0KCk7Cgl1c2xlZXAoMTAwMDAwKTsKCWR1bXBfcGl0KCk7Cgl1c2xlZXAoMTAw
MDAwKTsKCWR1bXBfcGl0KCk7CgoJcmV0dXJuIDA7Cn0K


--=-/xP/5EMQood0nPv+fEDF--

--=-5FxiMSjbSBwrghl1/Sjz
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwODAyMDk1NTMzWjAvBgkqhkiG9w0BCQQxIgQgZhpOr9X5
BxeB7DfoJerzB9bWhPWdLerta1PuNHxGwdgwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCmcjS7cmPTkhgs4j0RBRccssPRZU55XEpn
BKL/1frLy/bKbvXDJEezEe/3QiuCK6Il891upGxRXgLZ+4XCpVm97yos3qLYoCX5ZCMG1ctigNtr
j5lEWUNrB2EQfDg2NVCkcHuSSd2qxhL0oDqEG34U1S59giQg8zOLGvxT2O/8wLtczFgCR5HuiTux
v8vmu0DzbMlTFlj0uKWbUuD6ASy+Z15FmgDSgtyqDBKBgM60h9rzmf/xhXDyC5AQ+zBjmxFw9Gog
AVy4zPBHe6DrJu0v6uHmqK1uTBMJOiNiXbC8IG2M5m6G7YDFp5gWXkB/7mY/UNzwdH6EU1UFiQjR
r1JuzIoDNJMKD6vGVfYaMCOdg4la5UjRZvnfqtw6HY+do04/QBAAh9c+ge36chw1v6aeSWLgJFl0
aOo18ahyRgxNvHaajb7uuCjH5tDvQaFok8p7wzzxXhpfou/eJm7t30C/jOukwAD7EICK47I4pP7I
4iCPAkDQWs0/o2QDdUnXWJV3/+p2ysxdMqNLyNJwfeiAf32N57sV4oHemwAldgcTwtweiOPKV/UX
elb2p9l94hGyO0IWMxYbyEUfj21Jj2tS1Vu11cD2brNvuwoovYcTPTi3CYwL2tp7l7+2u503cH5v
JXbid2sHdKFjLkLU3JBx9aFAkdcsDzbyUnRCuIgQ4wAAAAAAAA==


--=-5FxiMSjbSBwrghl1/Sjz--

