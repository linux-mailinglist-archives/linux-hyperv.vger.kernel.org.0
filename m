Return-Path: <linux-hyperv+bounces-11092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCNOOEErDmpq6gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11092-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:44:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78959B425
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C3273041B84
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9C39FCB5;
	Wed, 20 May 2026 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWZ73e2a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515539EF32;
	Wed, 20 May 2026 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313458; cv=none; b=sIgKZgd4rIq+5oeQJvQZzNKMwmnnOOe0V135voBDG/JKuh+7mpQ1WJwSnAwKcFehsjYlCqzIlsnN8v7cqBNFLtx1lRL5IqpWU8pDk7sIMU+NXNUSFG9IxVBd7pzhgw+vHts0nbJX5wbb8anPSLTCY6mrypsUJGzbCxYoQAPScBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313458; c=relaxed/simple;
	bh=V+eATgFjWpKnSKJ5+sPGQpYVwR9soHFVnn/OiMK5Xu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fdt8Webm1elg7z4/P1zNUvoCzAsovNCnnkoPoLwXly9mEKCtr+/QC1J/d75NfJCaia7ag2v2eXc0MwibqEcitRstGXGYweRJ6+xFP6iSp3IdLfUFQfdIDTkIUM6kXESKcB7VODTCPweGJXDBQteCLTTi8yYqkb+L3ym75ACD2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DWZ73e2a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V+eATgFjWpKnSKJ5+sPGQpYVwR9soHFVnn/OiMK5Xu8=; b=DWZ73e2as4JZA5wGwlfPWL899B
	lD0QbdknJ5+LTfMizvdQ0Ltd3UyxnFmVZ/6KF+xY5Nt4xtAqHI+T5YgcwG2Gug4yGEUXjiptDo7h1
	a+FoiEL2zHsVAWUO1iZZYYmedl5/6ETBuIBKDhbopX57i2My7K9jNk56GrIwl3HnwCjbl7yAP7ctV
	4YhhryAvO6p5/bSuTOoK0+KL2aj5WiS4lHvHcPe2GjyCjcLD0iAYqwPgP03Lw3q2M2H4kboQ69h8b
	0U+9KwFbsneBjHn5oqHOZPfu7RwBidF5xkcqWAIWR8CItkSRmTLQnOWV7GUuKLLSXaCEXWzVkE/75
	87ObyEVw==;
Received: from 54-240-197-235.amazon.com ([54.240.197.235] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoi0-00000007bx6-0NuV;
	Wed, 20 May 2026 21:44:08 +0000
Message-ID: <a336f998f4d6ca1872eb1ce5867c89e54c228b8b.camel@infradead.org>
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
Date: Wed, 20 May 2026 22:44:06 +0100
In-Reply-To: <ag4or9-9c6VZxqya@google.com>
References: <20260515191942.1892718-1-seanjc@google.com>
	 <20260515191942.1892718-3-seanjc@google.com>
	 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
	 <ag4dMc2B3JQi4vxU@google.com>
	 <621e10bdc9e297c6c600b561d8fa25c3b62968bc.camel@infradead.org>
	 <ag4or9-9c6VZxqya@google.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-oxbeONMkNdqRjI4b1mSx"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11092-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B78959B425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-oxbeONMkNdqRjI4b1mSx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDE0OjMzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOgo+IE9uIFdlZCwgTWF5IDIwLCAyMDI2LCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6Cj4gPiBP
biBXZWQsIDIwMjYtMDUtMjAgYXQgMTM6NDQgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3Jv
dGU6Cj4gPiA+IAo+ID4gPiArwqDCoMKgwqDCoMKgIC8qCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IElmIHRoZSBUU0MgY291bnRzIGF0IGEgY29uc3RhbnQgZnJlcXVlbmN5IGFjcm9zcyBQL1Qgc3Rh
dGVzLCBjb3VudHMKPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogaW4gZGVlcCBDLXN0YXRlcywgYW5k
IHRoZSBUU0MgaGFzbid0IGJlZW4gbWFya2VkIHVuc3RhYmxlLCB0cmVhdCB0aGUKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgICogVFNDIHJlbGlhYmxlLCBhcyBndWFyYW50ZWVkIGJ5IEtWTS7CoCBOb3Rl
LCB0aGUgVFNDIHVuc3RhYmxlIGNoZWNrCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGV4aXN0cyBw
dXJlbHkgdG8gaG9ub3IgdGhlIFRTQyBiZWluZyBtYXJrZWQgdW5zdGFibGUgdmlhIGNvbW1hbmQK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgICogbGluZSwgYW55IHJ1bnRpbWUgZGV0ZWN0aW9uIG9mIGFu
IHVuc3RhYmxlIHdpbGwgaGFwcGVuIGFmdGVyIHRoaXMuCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAq
Lwo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ09OU1RB
TlRfVFNDKSAmJgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vdF9jcHVfaGFzKFg4Nl9G
RUFUVVJFX05PTlNUT1BfVFNDKSAmJgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWNoZWNr
X3RzY191bnN0YWJsZSgpKQo+ID4gwqDCoMKgIHsgCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHRzY19wcm9wZXJ0aWVzID0gVFNDX0ZSRVFfS05PV05fQU5EX1JFTElBQkxFOwo+
ID4gCj4gPiDCoMKgwqAga3ZtY2xvY2sgPSAwOyAvKiBXaHkgdXNlIGl0IGlmIHRoZSBUU0Mgd29y
a3M/IFRoZSBrdm1jbG9jayBleGlzdHMKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKnB1cmVseSogdG8gd29yayBhcm91bmQgYSBUU0Mgd2hpY2ggKmRvZXNuJ3Qq
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhhdmUgdGhvc2Ug
cHJvcGVydGllcyBjaGVja2VkIGFib3ZlLiAqLwo+IAo+IGt2bWNsb2NrIHN0aWxsIHByb3ZpZGVz
IFNZU1RFTV9USU1FIGFuZCBXQUxMX0NMT0NLIDotLwoKVW0sIFNZU1RFTV9USU1FICppcyogdGhl
IGt2bWNsb2NrIG9mIHdoaWNoIHdlIHNwZWFrLCBpc24ndCBpdD8KCldBTExfQ0xPQ0sgaXMgc29t
ZXRoaW5nIGVsc2UsIGFuZCBJIGd1ZXNzIHdlIHNob3VsZCBzdGlsbCBjb25zdW1lIHRoYXQsCnll
cy4KCj4gCj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoCBrdm1fdHNjX2toel9jcHVpZCA9IGt2
bV9wYXJhX3RzY19raHooKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgIC8qCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoCAqIElmIHByb3ZpZGVkLCB1c2UgdGhlIFRTQyAoYW5kIEFQSUMgYnVzKSBm
cmVxdWVuY3kgcHJvdmlkZWQgaW4gS1ZNJ3MKPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogUFYgQ1BV
SUQgbGVhZiBldmVuIGlmIGt2bWNsb2NrIGl0c2VsZiBpcyBkaXNhYmxlZCB2aWEgY29tbWFuZCBs
aW5lLgo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiBUaGUgUFYgQ1BVSUQgaW5mb3JtYXRpb24gaXNu
J3QgZGVwZW5kZW50IG9uIGt2bWNsb2NrIGluIGFueSB3YXksIGFuZAo+ID4gPiArwqDCoMKgwqDC
oMKgwqAgKiBpbiBmYWN0IHVzaW5nIHRoZSBwcmVjaXNlIGluZm9ybWF0aW9uIGlzICptb3JlKiBp
bXBvcnRhbnQgd2hlbiB0aGUKPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogdXNlciBoYXMgZXhwbGlj
aXRseSBkaXNhYmxlZCBrdm1jbG9jayB0byBmb3JjZSB0aGUga2VybmVsIHRvIHVzZSB0aGUKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgICogVFNDIGFzIGl0cyBjbG9ja3NvdXJjZS4KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgICovCj4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKCFrdm1jbG9jaykgewo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoa3ZtX3RzY19raHpfY3B1aWQpCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2NfcmVnaXN0
ZXJfY2FsaWJyYXRpb25fcm91dGluZXMoa3ZtX2dldF90c2Nfa2h6LAo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdm1fZ2V0X2Nw
dV9raHosCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRzY19wcm9wZXJ0aWVzKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuOwo+ID4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ID4gKwo+ID4gCj4gPiAK
PiA+IFJlZ2FyZGxlc3Mgb2YgdGhlIGFib3ZlLCB3aHkgbm90IGp1c3QgcmVnaXN0ZXIgdGhlc2Ug
aGVyZQo+ID4gdW5jb25kaXRpb25hbGx5LCBhbmQgcmVtb3ZlIHRoZSBsYXRlciBjYWxsIHRoYXQg
ZG9lcyB0aGUgc2FtZT8KPiAKPiBCZWNhdXNlIGlmIGt2bWNsb2NrPW4sIGl0J3Mgb25seSBzYWZl
IHRvIGNhbGwga3ZtX2dldF90c2Nfa2h6KCkgaWYga3ZtX3RzY19raHpfY3B1aWQKPiBpcyBub24t
emVybywgb3RoZXIgd2lzZSB0aGUgImVsc2UiIHBhdGggd2lsbCBoaXQgYSBOVUxMIHBvaW50ZXIg
ZGVyZWYgd2hlbiB0cnlpbmcKPiB0byBnZXQgdGhlIGZyZXF1ZW5jeSBmcm9tIHRoZSBQViBjbG9j
ayBzdHJ1Y3Q6Cj4gCj4gCXJldHVybiBrdm1fdHNjX2toel9jcHVpZCA/IDogcHZjbG9ja190c2Nf
a2h6KHRoaXNfY3B1X3B2dGkoKSk7CgpBaCwgcmlnaHQuIFRoYW5rcy4gSWNrIHRob3VnaCA6KQo=


--=-oxbeONMkNdqRjI4b1mSx
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDIxNDQw
NlowLwYJKoZIhvcNAQkEMSIEIEmBoU2SoTpbUcEINmHhbssFqM9cMtAcIF2RwoenHW4SMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAz/wiqoIcasKx
bjslyFyZ7yEgJVNn0JJcSpCgnFYroD+iQXtLV/szjY3km9e4EtHn0jmjHMNjJ+CHUi4yrcOU9OQp
i9Rx0olS3amDHQTwZ89HDSG8187RNnJC3Czqs0+ZE59fuMXwbmgCzablVsgZLXM6VWTISdfJgqH3
zn3UK2KojCLpQkCUO2fl4gknxzEP9TBbpQX52Wem0YlaHnIG6du9ht8hbouRfv0VnLuIKaSJB6KL
RuS3rc+TMlcVdUS7LzoDqxf4CT4HX2umWlwnthoAXCBs5H/ZEKucIF1YjKaSqLP/+pb0rRrmoPbX
1IUK87sMU+BKxXacDCBzOo9Pev3U7p1ba2NDddOVsARByzM2FTO8m3lP/dHk25sQ9AXqVuGSVn7+
a5yv5/ViBkKq/OsJ6BK0ANY/bHLl339Y8VAcLtDta4LrO7t1DJKxZgs8zkkjmOyD2fYPYQ6/3zU4
9Evwy/ycUyZiVhpnmFCuNHslfYs8RieMK8nqGcGgTxIeV+xn/N9Q6WDn7fiPZUXVg2aMSa2dNRCy
pQedYZNrVP8HADS4M3wkhgZH/e3x1+ogRtireu2rVLNKiOoOO14PNpayVX4CLSOgoOv+s9CyC7/G
lvrsjhfGNgdySpgl97YST+zUsUuj0iqKAUzGiZUlD2wh1sla0hW4cf59o7fcSnoAAAAAAAA=


--=-oxbeONMkNdqRjI4b1mSx--

