Return-Path: <linux-hyperv+bounces-11101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PojDkc3DmpC8gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11101-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 00:35:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F259C1FC
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83594302F549
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05B3BFE3F;
	Wed, 20 May 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="i4fEbCMp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.197.10.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD223C0626;
	Wed, 20 May 2026 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.197.10.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316534; cv=none; b=Nnhys8pSL0S+ImemynhS22UkUJ2XP+/tWZHAwn0YbsJJz87g31mlr6WYCmWIMZ05lyoeXEok22NBwKrkzta946zYN9Beer/dOnW4w7E6KcXLYRLIEm/GTId+V1zIn7l3ifjo6vqfczM2Rpw/7WhK1NoRBSq4mS9xLenT1cj8k9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316534; c=relaxed/simple;
	bh=xBOwPpf20AP49eh/LL3M8wYrZSUKjmTkQ42OItnico0=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=ajFTPvzhTZ616aPpOkbld3InzzEHC+jK516J0aTXvHt0EOTrIal/suWaF4uDhjeXNC9y2kB4ucDWs/vqM9+ZRWVomdYQR3w3FtibMgVmM754zDQwipn85NONTvSapJg+XOzQR/PqandVY1fWtILG9ZobWGPHmZQmo1QmWor6/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=i4fEbCMp; arc=none smtp.client-ip=34.197.10.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1779316532; x=1810852532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=gSw8rnwXQ0rhZeVx84L0W3uc6MkIiFaqVJq9n/+cEdc=;
  b=i4fEbCMpScAswzB5ALvYV8ScGGxTaeeMnrJOs3IusGcR4rUgAioq17o0
   scwQAHK2LXvQ5yF8yX0OOjJ0JkFj15C/YD7uJl04Nxm7tchWbIbxLCjKg
   9C3D0S+7BBtRuRe9iS1Tn/hbwcCpzc5sxT45rHMELA+V20erKjSQMk+Cz
   YOL3QZFyoj5uiMq0isljN6OU5d/n7WF7Znin42+ebZa41WvQWJsaHPgIW
   UnYQLnkRV4XHKbYpIuJrupBrU7pSFa4VRKP0iwSldaiOGxNOGo2UCiw7P
   kA7xCjqRwQxtQ2FFEfXnZvjhC5gO+4laIIw0kjQGKXVFtrqMI8ZJP4jYu
   g==;
X-CSE-ConnectionGUID: 5Q/LMkrsSYKzZPZuKRMfEQ==
X-CSE-MsgGUID: BEOYDa+3QkGrhQBheknQYg==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.23,245,1770595200"; 
   d="p7s'346?scan'346,208,346";a="18939673"
Content-Type: multipart/mixed; boundary="===============8743037896110918423=="
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-4-10-75.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.10.75])
  by internal-iad-out-012.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 22:35:28 +0000
Received: from EX19MTAUEB002.ant.amazon.com [72.21.198.67:6519]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.39.92:2525] with esmtp (Farcaster)
 id 59278547-ce4e-45a1-a98f-79b6d9967b7c; Wed, 20 May 2026 22:35:27 +0000 (UTC)
X-Farcaster-Flow-ID: 59278547-ce4e-45a1-a98f-79b6d9967b7c
Received: from EX19D001UEB003.ant.amazon.com (10.252.135.61) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 20 May 2026 22:35:27 +0000
Received: from EX19D001UEB002.ant.amazon.com (10.252.135.17) by
 EX19D001UEB003.ant.amazon.com (10.252.135.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 20 May 2026 22:35:26 +0000
Received: from EX19D001UEB002.ant.amazon.com ([fe80::19d6:e954:f18:6292]) by
 EX19D001UEB002.ant.amazon.com ([fe80::19d6:e954:f18:6292%3]) with mapi id
 15.02.2562.037; Wed, 20 May 2026 22:35:26 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: "tglx@kernel.org" <tglx@kernel.org>, "longli@microsoft.com"
	<longli@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
	"alexey.makhalov@broadcom.com" <alexey.makhalov@broadcom.com>,
	"jstultz@google.com" <jstultz@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ajay.kaher@broadcom.com"
	<ajay.kaher@broadcom.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jgross@suse.com" <jgross@suse.com>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "nikunj@amd.com" <nikunj@amd.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 18/41] x86/paravirt: Pass sched_clock save/restore
 helpers during registration
Thread-Topic: [PATCH v3 18/41] x86/paravirt: Pass sched_clock save/restore
 helpers during registration
Thread-Index: AQHc6Kj0fv5ul1kqCk6EoM3O36i5qw==
Date: Wed, 20 May 2026 22:35:26 +0000
Message-ID: <69226e77bcf1b93041f27843b6259921f226c0cc.camel@amazon.co.uk>
References: <20260515191942.1892718-1-seanjc@google.com>
	 <20260515191942.1892718-19-seanjc@google.com>
In-Reply-To: <20260515191942.1892718-19-seanjc@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
MIME-Version: 1.0
X-Spamd-Result: default: False [-11.26 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.co.uk:D:+];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.co.uk,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/mixed,multipart/signed,text/plain,multipart/alternative];
	R_DKIM_ALLOW(-0.20)[amazon.co.uk:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11101-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,amazon.co.uk:mid,amazon.co.uk:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,lists.linux.dev,vger.kernel.org,outlook.com,amd.com,broadcom.com,linutronix.de,lists.xenproject.org,redhat.com,intel.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw@amazon.co.uk,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.co.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B94F259C1FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============8743037896110918423==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-4SuH15PLIgNoHhsEZRux"

--=-4SuH15PLIgNoHhsEZRux
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> Pass in a PV clock's save/restore helpers when configuring sched_clock
> instead of relying on each PV clock to manually set the save/restore hook=
s.
> In addition to bringing sanity to the code, this will allow gracefully
> "rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
> access to a "secure" TSC.
>=20
> No functional change intended.
>=20
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Nice!

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -567,13 +567,12 @@ static void __init xen_init_time_common(void)
> =C2=A0{
> =C2=A0	xen_sched_clock_offset =3D xen_clocksource_read();
> =C2=A0	static_call_update(pv_steal_clock, xen_steal_clock);
> -	paravirt_set_sched_clock(xen_sched_clock);
> +
> =C2=A0	/*
> =C2=A0	 * Xen has paravirtualized suspend/resume and so doesn't use the c=
ommon
> =C2=A0	 * x86 sched_clock save/restore hooks.
> =C2=A0	 */
> -	x86_platform.save_sched_clock_state =3D NULL;
> -	x86_platform.restore_sched_clock_state =3D NULL;
> +	paravirt_set_sched_clock(xen_sched_clock, NULL, NULL);
> =C2=A0
> =C2=A0	tsc_register_calibration_routines(xen_tsc_khz, NULL);
> =C2=A0	x86_platform.get_wallclock =3D xen_get_wallclock;


Same deal here as with kvmclock, FWIW. If the TSC is viable, then it's
the better choice.=20

Especially now there's a significant chance that a "Xen guest" is
actually running under KVM. Xen never screwed its pvclock up quite as
much as KVM did :)

--=-4SuH15PLIgNoHhsEZRux
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkYw
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
5ZgtwCLXgAIe5W8mybM2JzCCBhUwggT9oAMCAQICEFQru/eJkU7BxeS7T6sWKmYwDQYJKoZIhvcN
AQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjQxMjE1MDAw
MDAwWhcNMjYxMjE1MjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFtYXpvbi5jby51azCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANhjs6T4tJ0lcw4+6sawEn2FowmhunUBsnSV
ccB+aA7s3Zd9PZV46CU6phAlCWpKk1yFVcD1Rnc4ux17o4LbUgFXiKrORS0jiF/5Oa0rXG3FISG1
Xdjt8oPKIq+9Z1s2e7Ipi5WWj4AG/xlkH/YMMctL9O8CCRHSrhiChbE/gR57x9PAnt5aeZZ2YWza
GOOeceaZe+u6vHCHITRmknSAnAX/aNoNJNsQCGcfrE83y9iHmP8BFrSRZqajBKlKq8tyJd5FnSwP
H3kSUcQlHOwiIfCRFXP4rpXSZ7nKOEZr3SXH06ADY9gZtrSpwBbuzKWDPGWMRuRnz8ogj/Y6DeU4
2zB/ZAIi5b0BzWf4u0rBEQD5xtpOCxYHc2nXQaFSWu36kP1JaNqElE51OQ92EyVKfW3N6qZcKiBr
VijXY2EtR+/5W9ixRFnEs4nIeb94Sf92UMEeG9ew2yVvcYXXNPaicGnrkESNC19/a8YXxQEZfrmB
eAPT9viQJhn3O+sD4pP0Ss3SjVZc6EO7vfoP07bt2n9YE08XSPkxcyb1J/4t/+AskkKeYFBGdpjg
xd+iLFxjSwBytZuh3+7DuHUfg876WA44ieQDrhHSjuvuAZ1Wb8WUsrpzrcLoYjqFmb/bf6/yyoxl
t31mdgPC+FLc+Yu1BQwXC3JMbrvbFBVTtn5X2EKDAgMBAAGjggHQMIIBzDAfBgNVHSMEGDAWgBQJ
wPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUWvtA1XsSV8xjgfFQL/DUTNIbJu4wDgYDVR0P
AQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwQwUAYDVR0gBEkwRzA6
BgwrBgEEAbIxAQIBCgIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9zZWN0aWdvLmNvbS9TTUlNRUNQ
UzAJBgdngQwBBQEDMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2Vj
dGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUF
BwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xp
ZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDov
L29jc3Auc2VjdGlnby5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24uY28udWswDQYJKoZIhvcN
AQELBQADggEBAED6T+rfP2XPdLfHoCd5n1iGIcYauWfPHRdZN2Tw7a7NEXIkm2yZNizOSpp3NrMi
WOBN13XgqnYLsqdpxJhbjwKczKX50/qfhhkOHtrQ0GRkucybK447Aaul80cZT8T3WG9U9dhl3Ct/
MuyKBWQg3MYlbUT6u4kC9Pk8rd+cR14ttYRUWDKTS2BrL7e8jpNmtCoEakDkMY4MrpoMwM1f4ANV
qZ8cnDntwXq5ormZIksN2DqxsKLmrFyVAONhqSST72ImBfIVWhFRTCF9tTcI5wE/0Skl25FZmSsB
B2LUgecgK7MZyw9Do/b0sYS+8YmA/ujUCqNb0fPJBE/B9vBomhswggYVMIIE/aADAgECAhBUK7v3
iZFOwcXku0+rFipmMA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTI0MTIxNTAwMDAwMFoXDTI2MTIxNTIzNTk1OVowIjEgMB4GCSqGSIb3DQEJ
ARYRZHdtd0BhbWF6b24uY28udWswggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYY7Ok
+LSdJXMOPurGsBJ9haMJobp1AbJ0lXHAfmgO7N2XfT2VeOglOqYQJQlqSpNchVXA9UZ3OLsde6OC
21IBV4iqzkUtI4hf+TmtK1xtxSEhtV3Y7fKDyiKvvWdbNnuyKYuVlo+ABv8ZZB/2DDHLS/TvAgkR
0q4YgoWxP4Eee8fTwJ7eWnmWdmFs2hjjnnHmmXvrurxwhyE0ZpJ0gJwF/2jaDSTbEAhnH6xPN8vY
h5j/ARa0kWamowSpSqvLciXeRZ0sDx95ElHEJRzsIiHwkRVz+K6V0me5yjhGa90lx9OgA2PYGba0
qcAW7sylgzxljEbkZ8/KII/2Og3lONswf2QCIuW9Ac1n+LtKwREA+cbaTgsWB3Np10GhUlrt+pD9
SWjahJROdTkPdhMlSn1tzeqmXCoga1Yo12NhLUfv+VvYsURZxLOJyHm/eEn/dlDBHhvXsNslb3GF
1zT2onBp65BEjQtff2vGF8UBGX65gXgD0/b4kCYZ9zvrA+KT9ErN0o1WXOhDu736D9O27dp/WBNP
F0j5MXMm9Sf+Lf/gLJJCnmBQRnaY4MXfoixcY0sAcrWbod/uw7h1H4PO+lgOOInkA64R0o7r7gGd
Vm/FlLK6c63C6GI6hZm/23+v8sqMZbd9ZnYDwvhS3PmLtQUMFwtyTG672xQVU7Z+V9hCgwIDAQAB
o4IB0DCCAcwwHwYDVR0jBBgwFoAUCcDy/AvalNtf/ivfqJlCz8ngrQAwHQYDVR0OBBYEFFr7QNV7
ElfMY4HxUC/w1EzSGybuMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMBMGA1UdJQQMMAoG
CCsGAQUFBwMEMFAGA1UdIARJMEcwOgYMKwYBBAGyMQECAQoCMCowKAYIKwYBBQUHAgEWHGh0dHBz
Oi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYHZ4EMAQUBAzBaBgNVHR8EUzBRME+gTaBLhklodHRw
Oi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuc2Vj
dGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMBwGA1UdEQQVMBOBEWR3bXdA
YW1hem9uLmNvLnVrMA0GCSqGSIb3DQEBCwUAA4IBAQBA+k/q3z9lz3S3x6AneZ9YhiHGGrlnzx0X
WTdk8O2uzRFyJJtsmTYszkqadzazIljgTdd14Kp2C7KnacSYW48CnMyl+dP6n4YZDh7a0NBkZLnM
myuOOwGrpfNHGU/E91hvVPXYZdwrfzLsigVkINzGJW1E+ruJAvT5PK3fnEdeLbWEVFgyk0tgay+3
vI6TZrQqBGpA5DGODK6aDMDNX+ADVamfHJw57cF6uaK5mSJLDdg6sbCi5qxclQDjYakkk+9iJgXy
FVoRUUwhfbU3COcBP9EpJduRWZkrAQdi1IHnICuzGcsPQ6P29LGEvvGJgP7o1AqjW9HzyQRPwfbw
aJobMYIExDCCBMACAQEwgaswgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNo
ZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UE
AxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EFQru/eJkU7BxeS7T6sWKmYwDQYJYIZIAWUDBAIBBQCgggHpMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDIyMzUyNVowLwYJKoZIhvcNAQkEMSIEIL2s+i5z
peY46Ptk9qjCSJOKEZrw5O7LYSh0B78gGztzMIG8BgkrBgEEAYI3EAQxga4wgaswgZYxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
BgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEFQru/eJkU7BxeS7T6sWKmYwgb4GCyqGSIb3
DQEJEAILMYGuoIGrMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhBUK7v3
iZFOwcXku0+rFipmMA0GCSqGSIb3DQEBAQUABIICADOnPyHOuAq054zVY9YGhJxO7Weim8TV3Mv+
IQQXLakRg9mUO3R9mM0OKP/yipEhYUKwntpnfxVh/+1WMRZG16pXRgiMmngl/rIF9T3nYrLua8sS
6yjLGeF1kbnViuPAhUMZaMCMVUY7TThYT5pY6eiWXhYgEpLIGtk+54n0w2HS5SF+ot86AOeZMzDW
OYCn8LLvkuAD5xCKSuMGRgcsdacZZ4g4iz02jzif5VnaDdeAtxZ9sRDAfOOBHHuI9unRkffcAl/S
XfxmARsV52J2VeyWh2J1Ef723VWayYNGZvmZbpJ4XEM9RzL0/GWeCY9ErMViUWXYCANRiT8PD/tf
u3K5vm5hGHCbW4G4KndzJ7Kqgs1lCHuNuucdl3OVszY9ntcWp/Am9t5XRaiJKhpQPh1UyuZ5ikOg
3sS4zu17fiBvtBemzQ/n+2HlLWpdVy9ggdJNprCOo1uXrkoIWouHtM7bhU90aEaVhEljpLl4HliU
wA++vIJ1qXSkeSeE8mR3OFNDHv1KDWE4y1RGdF2JoKeSKP9UFcfvo8KdnQSYq80KF31dgwLm5ZPf
CAzHt6ylFufRPkoca9fpNrkGj1dlLLBMImqcsiAe+FrD/XN5Zoyor6a08kvDIbvwH5RN32h7dVuA
f64X0LXa77752tE3HenWxcHB5Mj+da7CBds5/1x3AAAAAAAA


--=-4SuH15PLIgNoHhsEZRux--

--===============8743037896110918423==
Content-Type: multipart/alternative; boundary="===============2486592903892225233=="
MIME-Version: 1.0
Content-Disposition: inline

--===============2486592903892225233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============2486592903892225233==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============2486592903892225233==--
--===============8743037896110918423==--

