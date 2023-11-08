Return-Path: <linux-hyperv+bounces-758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56777E564F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B22812EF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C381798C;
	Wed,  8 Nov 2023 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gWlTg097"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F417990;
	Wed,  8 Nov 2023 12:30:43 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9782108;
	Wed,  8 Nov 2023 04:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699446642; x=1730982642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=huofa0+R25haFeC4UhIjPZEX1zuHz40x6zRaT9sM0jw=;
  b=gWlTg097yLwZqheKQnHuc6N7GGX8b2JqCqxLdtWIvE93SHOIFIe66LqR
   IF9rPzZd9FotaHLyjyL7J93GQoYn6HG9bpCrjRJVIro/bIGPllN7Sng3p
   kNrlzLoDdw6fCcPhybJ7ZYLnaSPehrDFMOcT74Hi1NL4DnPVdcDit7gbX
   I=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="164972291"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 12:30:42 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 4DFB180816;
	Wed,  8 Nov 2023 12:30:39 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:55388]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.225:2525] with esmtp (Farcaster)
 id b25abf23-17c8-4a98-b229-018faa5e7ba2; Wed, 8 Nov 2023 12:30:38 +0000 (UTC)
X-Farcaster-Flow-ID: b25abf23-17c8-4a98-b229-018faa5e7ba2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 12:30:38 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 12:30:34 +0000
Message-ID: <075453e1-830e-43bc-8888-7e5e4888223f@amazon.com>
Date: Wed, 8 Nov 2023 13:30:32 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 25/33] KVM: Introduce a set of new memory attributes
Content-Language: en-US
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, <kvm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
	<anelkz@amazon.com>, <dwmw@amazon.co.uk>, <jgowans@amazon.com>,
	<corbert@lwn.net>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
	<decui@microsoft.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20231108111806.92604-1-nsaenz@amazon.com>
 <20231108111806.92604-26-nsaenz@amazon.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20231108111806.92604-26-nsaenz@amazon.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDA4LjExLjIzIDEyOjE3LCBOaWNvbGFzIFNhZW56IEp1bGllbm5lIHdyb3RlOgo+IEludHJv
ZHVjZSB0aGUgZm9sbG93aW5nIG1lbW9yeSBhdHRyaWJ1dGVzOgo+ICAgLSBLVk1fTUVNT1JZX0FU
VFJJQlVURV9SRUFECj4gICAtIEtWTV9NRU1PUllfQVRUUklCVVRFX1dSSVRFCj4gICAtIEtWTV9N
RU1PUllfQVRUUklCVVRFX0VYRUNVVEUKPiAgIC0gS1ZNX01FTU9SWV9BVFRSSUJVVEVfTk9fQUND
RVNTCj4KPiBOb3RlIHRoYXQgTk9fQUNDRVNTIGlzIG5lY2Vzc2FyeSBpbiBvcmRlciB0byBtYWtl
IGEgZGlzdGluY3Rpb24gYmV0d2Vlbgo+IHRoZSBsYWNrIG9mIGF0dHJpYnV0ZXMgZm9yIGEgZ2Zu
LCB3aGljaCBkZWZhdWx0cyB0byB0aGUgbWVtb3J5Cj4gcHJvdGVjdGlvbnMgb2YgdGhlIGJhY2tp
bmcgbWVtb3J5LCB2ZXJzdXMgZXhwbGljaXRseSBwcm9oaWJpdGluZyBhbnkKPiBhY2Nlc3MgdG8g
dGhhdCBnZm4uCgoKSWYgd2UgbmVnYXRlIHRoZSBhdHRyaWJ1dGVzIChubyByZWFkLCBubyB3cml0
ZSwgbm8gZXhlY3V0ZSksIHdlIGNhbiBrZWVwIAowID09IGRlZmF1bHQgYW5kIDBiMTExIGJlY29t
ZXMgIm5vIGFjY2VzcyIuCgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDI4OSAyMzcgODc5CgoK


