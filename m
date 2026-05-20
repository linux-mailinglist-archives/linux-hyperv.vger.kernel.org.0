Return-Path: <linux-hyperv+bounces-11087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD+jFN1ADmqr9AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11087-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 01:16:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A159C59CA5C
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 01:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E640B30970E7
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284D37DEB9;
	Wed, 20 May 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzgYSL+9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600537E2FB;
	Wed, 20 May 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311973; cv=none; b=aAVgSyCHH2dy974uPFQjIjgznGA4ef1Fs82bdWsGe8riFXh27HivenulA/ZGpB2IdCuTcO4jVORX6XTeJ3xSLTBJIAFsf9UlhSkzG5/M2i2kwoZ5R5pQWvqU0XxxQ22Vz2kom96rO3XhhcLqief3vLSELq075CfFFRzQiM7wcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311973; c=relaxed/simple;
	bh=2T02KkRcNqHQW1Lp9kmhoNiqh8itBq6Uvl0wCCT1Bio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BrMSabIgkjh02UewR24XO/bpGGihxS7HInPsF8hdjY/ILdkVKQkfK4rebcIWfyL2UdpMjsRbCoowkg84t2emXEh9XqteQck808EG1C+ISy2CAwFRSvsSthKrpu6x46HVzUDPI0gP5HNsRTyiHBa1nAwjYdEvcAnWRhI61JONTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzgYSL+9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2T02KkRcNqHQW1Lp9kmhoNiqh8itBq6Uvl0wCCT1Bio=; b=RzgYSL+9m9JvdNIyWP36q3XkJO
	Nk3v7gLu9PPih2xcac5s9Zwy3uEdKi88oue80vbclyxBfh/sEdrtKY/4tkb4u+2V6dyul19hJO4gc
	F+IAuYrKjGIODQTeJwY49IPc7k6cvnN3zZzZo7h2KgwYQ3fqUpfOttTbg7dpxsLlpdzuFNbOeo2wa
	sP7p5x5a5ECsFi23z9NcBMQdkqcQEveo1E78SK4uMA1bc85cdi5x+slspcFgNztkUxM0b8/Y8rkQ4
	PBJWktM5UgvY3+/uw83eoZxMYhqNsqzbpXonsL/v2P3+B6YkDkmIvfdYPyuicJB1nlD4zSVmnNjvI
	bGwYbeCA==;
Received: from [54.240.197.227] (helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoK1-00000007aua-0ZJM;
	Wed, 20 May 2026 21:19:21 +0000
Message-ID: <621e10bdc9e297c6c600b561d8fa25c3b62968bc.camel@infradead.org>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC
 freq calibration routines
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 John Stultz <jstultz@google.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>,
 x86@kernel.org,  linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org,  virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,  xen-devel@lists.xenproject.org, Michael
 Kelley <mhklinux@outlook.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 20 May 2026 22:19:19 +0100
In-Reply-To: <ag4dMc2B3JQi4vxU@google.com>
References: <20260515191942.1892718-1-seanjc@google.com>
	 <20260515191942.1892718-3-seanjc@google.com>
	 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
	 <ag4dMc2B3JQi4vxU@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-VYaNBcSebu2vVTBLAdmQ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-4.16 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11087-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A159C59CA5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-VYaNBcSebu2vVTBLAdmQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDEzOjQ0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOgo+IAo+ICvCoMKgwqDCoMKgwqAgLyoKPiArwqDCoMKgwqDCoMKgwqAgKiBJZiB0aGUgVFND
IGNvdW50cyBhdCBhIGNvbnN0YW50IGZyZXF1ZW5jeSBhY3Jvc3MgUC9UIHN0YXRlcywgY291bnRz
Cj4gK8KgwqDCoMKgwqDCoMKgICogaW4gZGVlcCBDLXN0YXRlcywgYW5kIHRoZSBUU0MgaGFzbid0
IGJlZW4gbWFya2VkIHVuc3RhYmxlLCB0cmVhdCB0aGUKPiArwqDCoMKgwqDCoMKgwqAgKiBUU0Mg
cmVsaWFibGUsIGFzIGd1YXJhbnRlZWQgYnkgS1ZNLsKgIE5vdGUsIHRoZSBUU0MgdW5zdGFibGUg
Y2hlY2sKPiArwqDCoMKgwqDCoMKgwqAgKiBleGlzdHMgcHVyZWx5IHRvIGhvbm9yIHRoZSBUU0Mg
YmVpbmcgbWFya2VkIHVuc3RhYmxlIHZpYSBjb21tYW5kCj4gK8KgwqDCoMKgwqDCoMKgICogbGlu
ZSwgYW55IHJ1bnRpbWUgZGV0ZWN0aW9uIG9mIGFuIHVuc3RhYmxlIHdpbGwgaGFwcGVuIGFmdGVy
IHRoaXMuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoCBpZiAoYm9vdF9jcHVf
aGFzKFg4Nl9GRUFUVVJFX0NPTlNUQU5UX1RTQykgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX05PTlNUT1BfVFNDKSAmJgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoCAhY2hlY2tfdHNjX3Vuc3RhYmxlKCkpCiAgICB7IAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRzY19wcm9wZXJ0aWVzID0gVFNDX0ZSRVFfS05PV05fQU5EX1JFTElBQkxF
OwoKICAgIGt2bWNsb2NrID0gMDsgLyogV2h5IHVzZSBpdCBpZiB0aGUgVFNDIHdvcmtzPyBUaGUg
a3ZtY2xvY2sgZXhpc3RzCiAgICAgICAgICAgICAgICAgICAgICpwdXJlbHkqIHRvIHdvcmsgYXJv
dW5kIGEgVFNDIHdoaWNoICpkb2Vzbid0KgogICAgICAgICAgICAgICAgICAgICBoYXZlIHRob3Nl
IHByb3BlcnRpZXMgY2hlY2tlZCBhYm92ZS4gKi8KICAgIH0KCkkgd2FzIGdvaW5nIHRvIHNheSBQ
VkNMT0NLX1RTQ19TVEFCTEVfQklULCBhbmQgbWF5YmUgd2Ugc2hvdWxkIGNoZWNrCnRoYXQgKnRv
byogZm9yIHBhcmFub2lhPyBCdXQgaG9wZWZ1bGx5IHRoZSBjaGVja3MgeW91IGhhdmUgYWJvdmUg
YXJlCmVxdWl2YWxlbnQ/Cgo+ICsKPiArwqDCoMKgwqDCoMKgIGt2bV90c2Nfa2h6X2NwdWlkID0g
a3ZtX3BhcmFfdHNjX2toeigpOwo+ICsKPiArwqDCoMKgwqDCoMKgIC8qCj4gK8KgwqDCoMKgwqDC
oMKgICogSWYgcHJvdmlkZWQsIHVzZSB0aGUgVFNDIChhbmQgQVBJQyBidXMpIGZyZXF1ZW5jeSBw
cm92aWRlZCBpbiBLVk0ncwo+ICvCoMKgwqDCoMKgwqDCoCAqIFBWIENQVUlEIGxlYWYgZXZlbiBp
ZiBrdm1jbG9jayBpdHNlbGYgaXMgZGlzYWJsZWQgdmlhIGNvbW1hbmQgbGluZS4KPiArwqDCoMKg
wqDCoMKgwqAgKiBUaGUgUFYgQ1BVSUQgaW5mb3JtYXRpb24gaXNuJ3QgZGVwZW5kZW50IG9uIGt2
bWNsb2NrIGluIGFueSB3YXksIGFuZAo+ICvCoMKgwqDCoMKgwqDCoCAqIGluIGZhY3QgdXNpbmcg
dGhlIHByZWNpc2UgaW5mb3JtYXRpb24gaXMgKm1vcmUqIGltcG9ydGFudCB3aGVuIHRoZQo+ICvC
oMKgwqDCoMKgwqDCoCAqIHVzZXIgaGFzIGV4cGxpY2l0bHkgZGlzYWJsZWQga3ZtY2xvY2sgdG8g
Zm9yY2UgdGhlIGtlcm5lbCB0byB1c2UgdGhlCj4gK8KgwqDCoMKgwqDCoMKgICogVFNDIGFzIGl0
cyBjbG9ja3NvdXJjZS4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgIGlmICgh
a3ZtY2xvY2spIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoa3ZtX3RzY19r
aHpfY3B1aWQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRzY19yZWdpc3Rlcl9jYWxpYnJhdGlvbl9yb3V0aW5lcyhrdm1fZ2V0X3RzY19raHosCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga3Zt
X2dldF9jcHVfa2h6LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRzY19wcm9wZXJ0aWVzKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47Cj4gK8KgwqDCoMKgwqDCoCB9Cj4gKwoKClJlZ2FyZGxlc3Mgb2YgdGhl
IGFib3ZlLCB3aHkgbm90IGp1c3QgcmVnaXN0ZXIgdGhlc2UgaGVyZQp1bmNvbmRpdGlvbmFsbHks
IGFuZCByZW1vdmUgdGhlIGxhdGVyIGNhbGwgdGhhdCBkb2VzIHRoZSBzYW1lPwo=


--=-VYaNBcSebu2vVTBLAdmQ
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDIxMTkx
OVowLwYJKoZIhvcNAQkEMSIEINhvu80Esasizc/IrdUGbWb0meAtd12BJXV3+c9suECwMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAjn/O/SoEwAbs
YaXatoOuo8GSukimv9TlOJECjOZobWrlR4CEhwquW+XWRwlyZ8+eQQ4xu8AooNdh52B0fRNE3DeT
u65bXJuPgiLZuFlLy1iom72SwPtRrtlfQZPYQfYJl2SKVrr6bujGyhrSnO3tuZE/LOKXfFWiP3Yj
I9+Z89WHkGl2eY+Q4ZjUw0eK/fJre2PBt1BdpFHjxZG1WWhYGYIUoSZ62kNkxTWfrd2C3xr9Lzy0
wNSBOFB00yP3AgCAFhjHQmpkDTrugWIhsRmi8pvzVKxwaepUciccAe4Tx3CgCoIP5Q5KXknnIu1i
9my+2+xsG7JpVzRSgJj59jLNkQqlwCT57gIA5bQ5UNUYgxiBlT0mK5Q+ISXIMn6a9PIy78Z3bCam
TwWWH57PNX3g2yr3yxWNs1MgT9Z+RLpVp/ywq6in29MOkjDPJkPlVUc2qNLqfoXwDwDv0YlehAPA
D15sxI/yfeAVZVbOHZCIx47lSJRqAITMiHqY/qptT5u7eP0XtgczvRvyPZMzBIelPI3Ti7Be4bm9
UQTCTXCO37ARS3qnHAmQQW24h0KRCp9yXkmD4F17iP4aci79W6+jP8HQ+qzj+AhrsZEp9ix1NBo/
niFXiIy7mz2DN0n3EATdDw1AtJuGs82eyYjgQ6dpqEmw3xFsdXBGln/AkowqCXIAAAAAAAA=


--=-VYaNBcSebu2vVTBLAdmQ--

