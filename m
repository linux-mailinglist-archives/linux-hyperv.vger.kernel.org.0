Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1F2CB256
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 02:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgLBB3O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Dec 2020 20:29:14 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10354 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbgLBB3N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Dec 2020 20:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1606872553; x=1638408553;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=6uQon/BDh41ppN5GvD7f9z1OblxFV9nsodeQ2f7UCM8=;
  b=Ps+iLDMBLNv7A0TkILhrm2jqUixnXKMm5F87GTSfgEyH6/K01T4XWLNx
   cXwIk0VWOJoxQMoxoF2n/Ep5jt0gb6VWK5ZTy+E+j/k2WX3jQ+Ir+b1T2
   uDKEi4YxEKtCX+GwfdjD+ceTvpA/9kmyqu1rwVfODZUGVsj4Amx6fxIpH
   Q=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="69920108"
Subject: Re: [PATCH] iommu/hyper-v: Fix panic on a host without the 15-bit APIC ID
 support
Thread-Topic: [PATCH] iommu/hyper-v: Fix panic on a host without the 15-bit APIC ID support
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 02 Dec 2020 01:28:25 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 6B7FBA02E2;
        Wed,  2 Dec 2020 01:28:21 +0000 (UTC)
Received: from EX13D08UEE002.ant.amazon.com (10.43.62.92) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 01:28:20 +0000
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13D08UEE002.ant.amazon.com (10.43.62.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 01:28:20 +0000
Received: from EX13D08UEE001.ant.amazon.com ([10.43.62.126]) by
 EX13D08UEE001.ant.amazon.com ([10.43.62.126]) with mapi id 15.00.1497.006;
 Wed, 2 Dec 2020 01:28:20 +0000
From:   "Woodhouse, David" <dwmw@amazon.co.uk>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Thread-Index: AQHWyESU8Wh/35CKPEa9TIPiCA4xtanjBEuA
Date:   Wed, 2 Dec 2020 01:28:20 +0000
Message-ID: <eba320d980578ff37685967f8cafa5cf3ecb48e2.camel@amazon.co.uk>
References: <20201202004510.1818-1-decui@microsoft.com>
In-Reply-To: <20201202004510.1818-1-decui@microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A329C9F40A52B649A5E7C2D7B41E30A1@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDE2OjQ1IC0wODAwLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiBU
aGUgY29tbWl0IGYzNmE3NGI5MzQ1YSBpdHNlbGYgaXMgZ29vZCwgYnV0IGl0IGNhdXNlcyBhIHBh
bmljIGluIGENCj4gTGludXggVk0gdGhhdCBydW5zIG9uIGEgSHlwZXItViBob3N0IHRoYXQgZG9l
c24ndCBoYXZlIHRoZSAxNS1iaXQNCj4gRXh0ZW5kZWQgQVBJQyBJRCBzdXBwb3J0Og0KPiAgICAg
a2VybmVsIEJVRyBhdCBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9pb19hcGljLmM6MjQwOCENCj4gDQo+
IFRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSBIeXBlci1WIGlvYXBpY19pcl9kb21haW4gKHdoaWNo
IGlzIGRlZmluZWQgaW4NCj4gZHJpdmVycy9pb21tdS9oeXBlcnYtaW9tbXUuYykgY2FuIG5vdCBi
ZSBmb3VuZC4gRml4IHRoZSBwYW5pYyBieQ0KPiBwcm9wZXJseSBjbGFpbWluZyB0aGUgb25seSBJ
L08gQVBJQyBlbXVsYXRlZCBieSBIeXBlci1WLg0KPiANCj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8
ZHdtd0BhbWF6b24uY28udWs+DQo+IENjOiBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRo
YXQuY29tPg0KPiBGaXhlczogZjM2YTc0YjkzNDVhICgieDg2L2lvYXBpYzogVXNlIEkvTy1BUElD
IElEIGZvciBmaW5kaW5nIGlycWRvbWFpbiwgbm90IGluZGV4IikNCj4gU2lnbmVkLW9mZi1ieTog
RGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCg0KT29wcywgYXBvbG9naWVzIGZvciBt
aXNzaW5nIHRoYXQuDQoNClJldmlld2VkLWJ5OiBEYXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9u
LmNvLnVrPg0KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRyZSAoTG9uZG9uKSBMdGQuIFJlZ2lz
dGVyZWQgaW4gRW5nbGFuZCBhbmQgV2FsZXMgd2l0aCByZWdpc3RyYXRpb24gbnVtYmVyIDA0NTQz
MjMyIHdpdGggaXRzIHJlZ2lzdGVyZWQgb2ZmaWNlIGF0IDEgUHJpbmNpcGFsIFBsYWNlLCBXb3Jz
aGlwIFN0cmVldCwgTG9uZG9uIEVDMkEgMkZBLCBVbml0ZWQgS2luZ2RvbS4KCgo=

