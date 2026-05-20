Return-Path: <linux-hyperv+bounces-11091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EfnMrUoDmqk6gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11091-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:33:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7717659B04A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8FEB30265B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA6039EF0B;
	Wed, 20 May 2026 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFk1JBz9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFF38F929
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312819; cv=none; b=hqSLFFPzQ5lOw5vDbi1J6muoQs3eWXIvB9blGe9lACujE/vxf/zRQEXyZzk3HQEE6/QQa3UsxUGkDODMWfA/bhNYLKCvtJzSExUKU4JkakKARRyzH1kUVk6QXbmTQx87f84/3eVvmZHACv4P1Wy3wMOLiI4Mrxr7UkQcM6vzNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312819; c=relaxed/simple;
	bh=LZSsn4W0FsDL+gHozCZFUr2SRc1gslr4/bysNvveKJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6bi12vMp9avJ1eNtgI2REEVP8EjveSGxqJ/G9QacsYnZ0tUUkq8qsaZBu5gsPhDtss7QOJQcRlXzYHYQjZPoP1yw7R+HsyZvj0uK3W2FCOc3JgovcI47dImPctb7OKrSXl9PpRHzOT2JD5r98NGXlX4zhFfXpxhIwh1KxvKrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFk1JBz9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8291230235so8468987a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779312816; x=1779917616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZSsn4W0FsDL+gHozCZFUr2SRc1gslr4/bysNvveKJE=;
        b=cFk1JBz9Qs9DDBRirm9gIFHkJm8LdRsO6HLe+og0IWdUAGqK/MzY//q6NuH4Mtaz3/
         c04eMPwPcxTDa5loCCixlq706FQSwC+D5izthBkuBj00bT5dYIH6S/jbkC8v6DgzNzlw
         xb/GD+fdQ3mVtSPOU5+itxsqNTzNP1YUooWrIZtGAQU6pHNhssYjBhfb36X+d6ImJU5s
         EgNo76C4uLqSwqAQkQ0t8i7u/sOCDxheQgoA8S4nUg0b1qasa65usnru69T0Tr97LUqX
         a9Ik9LURARLqf1xzlAsYweGXkR6grwsxRKtCEcblNYY66/V9/hJayHM+KwYChKRplMaf
         NmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312816; x=1779917616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZSsn4W0FsDL+gHozCZFUr2SRc1gslr4/bysNvveKJE=;
        b=FTXeLgmFxj9G2zp1FxVWIitbBk5P+wGKdC6nYN0ct0zHQGaOPTqyX44mlu2pNPcpUP
         s897sxuaAYamQ5nct7cIIe09j04Py0zRnrrpvKs689cu9C/mNNsLMRjxnybQlQnuEHq7
         OmMlfPn6IIB30iPWfhCWtzExxsDgcO3fUs0Eirb4vbSbJ+XqwgQTepe8FqaNJNxt+ZUD
         PAj0fKDfppOlrWhoxsZRFKMgyoel+o9tekMLKpjp82/fqRTbfr+iU8r3DogedFLOkDvi
         eHxICw5rsd5+sLO8vfHigpGu/9O9jIjDr4vc4Yj4Mn863Jj2n6+C5TomsTAQw4xgn1ep
         dQVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f3/jnCQ2PU/H3mgw/GquIxFeKBfA7Sa2/zBRFNwpmraEp+Ug8JdV4HVNk8oz++zE5ddycc1GnUMFy5/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKryuhFLMYDg69ZxEDvkZNi1oSLFWQY5RmbLuu4n7oJfZVeBKW
	sYktNqTiHVA5S1GLiS/XXEzrjz8ATVwpBRNnPlXClm5Bp1r9+3Tsi/4VpVYe5P0fyxUA+aNNs5x
	A7SvPBw==
X-Received: from pgdh5.prod.google.com ([2002:a05:6a02:5185:b0:c79:7107:a67a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa8:b0:3a0:b65a:5dd1
 with SMTP id adf61e73a8af0-3b3081bfb61mr164633637.0.1779312816324; Wed, 20
 May 2026 14:33:36 -0700 (PDT)
Date: Wed, 20 May 2026 14:33:35 -0700
In-Reply-To: <621e10bdc9e297c6c600b561d8fa25c3b62968bc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
 <ag4dMc2B3JQi4vxU@google.com> <621e10bdc9e297c6c600b561d8fa25c3b62968bc.camel@infradead.org>
Message-ID: <ag4or9-9c6VZxqya@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11091-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,microsoft.com,broadcom.com,siemens.com,linux.intel.com,infradead.org,suse.com,google.com,intel.com,oracle.com,lists.linux.dev,vger.kernel.org,lists.xenproject.org,outlook.com,amd.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7717659B04A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBNYXkgMjAsIDIwMjYsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToKPiBPbiBXZWQsIDIw
MjYtMDUtMjAgYXQgMTM6NDQgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gPiAK
PiA+ICvCoMKgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIElmIHRoZSBUU0MgY291
bnRzIGF0IGEgY29uc3RhbnQgZnJlcXVlbmN5IGFjcm9zcyBQL1Qgc3RhdGVzLCBjb3VudHMKPiA+
ICvCoMKgwqDCoMKgwqDCoCAqIGluIGRlZXAgQy1zdGF0ZXMsIGFuZCB0aGUgVFNDIGhhc24ndCBi
ZWVuIG1hcmtlZCB1bnN0YWJsZSwgdHJlYXQgdGhlCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBUU0Mg
cmVsaWFibGUsIGFzIGd1YXJhbnRlZWQgYnkgS1ZNLsKgIE5vdGUsIHRoZSBUU0MgdW5zdGFibGUg
Y2hlY2sKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGV4aXN0cyBwdXJlbHkgdG8gaG9ub3IgdGhlIFRT
QyBiZWluZyBtYXJrZWQgdW5zdGFibGUgdmlhIGNvbW1hbmQKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IGxpbmUsIGFueSBydW50aW1lIGRldGVjdGlvbiBvZiBhbiB1bnN0YWJsZSB3aWxsIGhhcHBlbiBh
ZnRlciB0aGlzLgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgIGlmIChi
b290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ09OU1RBTlRfVFNDKSAmJgo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9OT05TVE9QX1RTQykgJiYKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoCAhY2hlY2tfdHNjX3Vuc3RhYmxlKCkpCj4gICAgIHsgCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2NfcHJvcGVydGllcyA9IFRTQ19GUkVRX0tO
T1dOX0FORF9SRUxJQUJMRTsKPiAKPiAgICAga3ZtY2xvY2sgPSAwOyAvKiBXaHkgdXNlIGl0IGlm
IHRoZSBUU0Mgd29ya3M/IFRoZSBrdm1jbG9jayBleGlzdHMKPiAgICAgICAgICAgICAgICAgICAg
ICAqcHVyZWx5KiB0byB3b3JrIGFyb3VuZCBhIFRTQyB3aGljaCAqZG9lc24ndCoKPiAgICAgICAg
ICAgICAgICAgICAgICBoYXZlIHRob3NlIHByb3BlcnRpZXMgY2hlY2tlZCBhYm92ZS4gKi8KCmt2
bWNsb2NrIHN0aWxsIHByb3ZpZGVzIFNZU1RFTV9USU1FIGFuZCBXQUxMX0NMT0NLIDotLwoKPiAg
ICAgfQo+IAo+IEkgd2FzIGdvaW5nIHRvIHNheSBQVkNMT0NLX1RTQ19TVEFCTEVfQklULCBhbmQg
bWF5YmUgd2Ugc2hvdWxkIGNoZWNrCj4gdGhhdCAqdG9vKiBmb3IgcGFyYW5vaWE/CgpObz8gUFZD
TE9DS19UU0NfU1RBQkxFIGlzIHByb3BlcnR5IG9mIGt2bWNsb2NrIG1vcmUgdGhhbiBpdCdzIGEg
cHJvcGVydHkgb2YgdGhlClRTQyBpdHNlbGYuICBBbmQgZm9yIHRoZSBuby1rdm1jbG9jayBjYXNl
LCB3ZSBtb3N0IGRlZmluaXRlbHkgZG9uJ3Qgd2FudCB0byBzZXR1cAprdm1jbG9jayBqdXN0IHRv
IHF1ZXJ5IHRoYXQgZmxhZy4KCj4gQnV0IGhvcGVmdWxseSB0aGUgY2hlY2tzIHlvdSBoYXZlIGFi
b3ZlIGFyZSBlcXVpdmFsZW50PwoKVGhleSBhcmVuJ3QgYXMgcGFyYW5vaWQsIGJ1dCBpZiB0aGUg
aG9zdCBlbnVtZXJhdGVzIENPTlNUQU5UK05PTlNUT1AgVFNDIGRlc3BpdGUKS1ZNLXRoZS1ob3N0
IG5vdCBiZWluZyBhYmxlIHRvIGFkdmVydGlzZSBQVkNMT0NLX1RTQ19TVEFCTEVfQklULCB0aGVu
IHRoZSBWTU0gZG9uZQptZXNzZWQgdXAuCgo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBrdm1fdHNj
X2toel9jcHVpZCA9IGt2bV9wYXJhX3RzY19raHooKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAg
LyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIElmIHByb3ZpZGVkLCB1c2UgdGhlIFRTQyAoYW5kIEFQ
SUMgYnVzKSBmcmVxdWVuY3kgcHJvdmlkZWQgaW4gS1ZNJ3MKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IFBWIENQVUlEIGxlYWYgZXZlbiBpZiBrdm1jbG9jayBpdHNlbGYgaXMgZGlzYWJsZWQgdmlhIGNv
bW1hbmQgbGluZS4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSBQViBDUFVJRCBpbmZvcm1hdGlv
biBpc24ndCBkZXBlbmRlbnQgb24ga3ZtY2xvY2sgaW4gYW55IHdheSwgYW5kCj4gPiArwqDCoMKg
wqDCoMKgwqAgKiBpbiBmYWN0IHVzaW5nIHRoZSBwcmVjaXNlIGluZm9ybWF0aW9uIGlzICptb3Jl
KiBpbXBvcnRhbnQgd2hlbiB0aGUKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHVzZXIgaGFzIGV4cGxp
Y2l0bHkgZGlzYWJsZWQga3ZtY2xvY2sgdG8gZm9yY2UgdGhlIGtlcm5lbCB0byB1c2UgdGhlCj4g
PiArwqDCoMKgwqDCoMKgwqAgKiBUU0MgYXMgaXRzIGNsb2Nrc291cmNlLgo+ID4gK8KgwqDCoMKg
wqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgIGlmICgha3ZtY2xvY2spIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChrdm1fdHNjX2toel9jcHVpZCkKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2NfcmVnaXN0ZXJfY2FsaWJy
YXRpb25fcm91dGluZXMoa3ZtX2dldF90c2Nfa2h6LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga3ZtX2dldF9jcHVfa2h6LAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dHNjX3Byb3BlcnRpZXMpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
Owo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArCj4gCj4gCj4gUmVnYXJkbGVzcyBvZiB0aGUgYWJv
dmUsIHdoeSBub3QganVzdCByZWdpc3RlciB0aGVzZSBoZXJlCj4gdW5jb25kaXRpb25hbGx5LCBh
bmQgcmVtb3ZlIHRoZSBsYXRlciBjYWxsIHRoYXQgZG9lcyB0aGUgc2FtZT8KCkJlY2F1c2UgaWYg
a3ZtY2xvY2s9biwgaXQncyBvbmx5IHNhZmUgdG8gY2FsbCBrdm1fZ2V0X3RzY19raHooKSBpZiBr
dm1fdHNjX2toel9jcHVpZAppcyBub24temVybywgb3RoZXIgd2lzZSB0aGUgImVsc2UiIHBhdGgg
d2lsbCBoaXQgYSBOVUxMIHBvaW50ZXIgZGVyZWYgd2hlbiB0cnlpbmcKdG8gZ2V0IHRoZSBmcmVx
dWVuY3kgZnJvbSB0aGUgUFYgY2xvY2sgc3RydWN0OgoKCXJldHVybiBrdm1fdHNjX2toel9jcHVp
ZCA/IDogcHZjbG9ja190c2Nfa2h6KHRoaXNfY3B1X3B2dGkoKSk7Cg==

