Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6A1E9451
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 May 2020 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgE3WlG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 30 May 2020 18:41:06 -0400
Received: from mail-eopbgr1320121.outbound.protection.outlook.com ([40.107.132.121]:4896
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729183AbgE3WlF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 May 2020 18:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlOhNa+8wDQYHA7EIiQYaKgG2RRn3zrA3R0omg9zYwfqqGE2Ao32uvWUIQCcNChMm7xUfVyRLFQ94U83p5kYkiQNnH/gE4zhQM3KlQC1O7gTMxfrTrHQOzMdMMjF6n54ZOcWOLY08zKPc+/E/+pfs+tGbZUEyEr+gn9LHF35hWxuIRM9H9jUxWNwhQBcgWIpabZqo6nZbCJXpVrLBZ0l7RuGldIQLK8jLNS0Fv9rxHPCEhm+uh9S3diuSd0bFA4axTb9X7P6Bd75rIeiQOw1xAt2GOEA3HJgXPTEyJRJowhRXhjppEBxfH6y9+QskqSxT30/MzMXV1id9jlrKkh5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEEIAHSxw/4tpS61pnCBWbzdaY+kHdW4fBy63KlxzMs=;
 b=Kv3qNLjuiYDvt4iH11iD4ZEoqv0vzmbrJqYZplujFfkNroOsi/gt+VwY2/VcZBStpCiOyMgxmcLHJ+PaRmD6c++kCelyZtdKxQUxdcZ6ULfeMqzMqrpCRIkJHGU8CZ3z3m5IfpZAz+uChPZZ/Sg9c5K5YcBRAl8oyNxrHr41prfrcVM9wuDHoQB7QmuOytmbudO+vz3/2AF/CoRXRt7VZBNcPEdAOa1fiewbe/iJFqtKVxDzIBxLhudxB16K6KzRhUbYgmGRgL6Ud/W7OEgt0r+NlqlzkArhK5DH7eUrTYVV5qexmWF8AzYxzNTnOPvc2Icr8UgIqd+SbHP9UTEa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEEIAHSxw/4tpS61pnCBWbzdaY+kHdW4fBy63KlxzMs=;
 b=SNiHAFey8zokg60l8g4wm+ymGGLTq+El1e802vC7oCDje5lRK3XG1H9ywINobW2ZdiBq94PtdzggX5lKUY48+cxMHqQ9USLzixizKahjGnRE/XoXM07ZbC/SgZPBE5UAzzdmld7+eY9APsj95n0R0VgntGaB3CYeNcVEEeRv8F8=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (2603:1096:203:29::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.3; Sat, 30 May
 2020 22:40:55 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::6c4e:82cb:2bab:9f7f]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::6c4e:82cb:2bab:9f7f%9]) with mapi id 15.20.3066.010; Sat, 30 May 2020
 22:40:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "namit@vmware.com" <namit@vmware.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] x86/apic/flat64: Add back the early_param("apic",
 parse_apic)
Thread-Topic: [PATCH] x86/apic/flat64: Add back the early_param("apic",
 parse_apic)
Thread-Index: AQHWNb2zxzgWHQ3PPEakjaqT5Cd426jBOt7g
Date:   Sat, 30 May 2020 22:40:54 +0000
Message-ID: <HK0P153MB0322004EF1DDCECA6889A73ABF8C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200529063729.22047-1-decui@microsoft.com>
 <928eb231-242c-d2b1-d40b-a2892c55b415@infradead.org>
In-Reply-To: <928eb231-242c-d2b1-d40b-a2892c55b415@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-30T22:40:52Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d672a0a-cf14-4fda-8938-6a4c28ebe965;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:3c58:b8dd:df9:11e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cbf31bb-9701-4efe-c04d-08d804ea83bd
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB017837D6D447A2F05755DA38BF8C0@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJoq3o5uM+MXjdioGNyvVm/8pD9qGd/SF1Tb6+IIVvkMt8IbJYN4s9HK0Q+KytobW4SKz8Beq9Yu7aP+xt96ShotIt9K8eW/JoNwptBaiRl930tjokqkt/d/yxHGsHgplVJIPIYMtgYsKdBt8yj+UWFQ+4iLDPrVbokb4X6iWIRErYHkEHo/ch9dI0bUdCfpOQJamv3LNTZHlkZsL+oXWimTHhUKWTRivwZpyM6R1a5dAht248jcqlqowWfLkhzyFEDAgeglzoKpc6C5V9e4vZPCGoOm53p3CRAENAGDpS7/p7H5Kg3qoymIRBj8+XwI81OXu+RpQLMxO2mS+y6bhi2X9SQyY+Qo/6jNFL1Y5Z0jNd4rqeJL7/vTNpCnp19c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(82960400001)(82950400001)(10290500003)(86362001)(478600001)(8990500004)(8676002)(8936002)(76116006)(64756008)(66556008)(66946007)(66476007)(66446008)(7416002)(52536014)(110136005)(316002)(54906003)(5660300002)(6506007)(71200400001)(4326008)(186003)(6636002)(55016002)(9686003)(2906002)(4744005)(33656002)(83380400001)(7696005)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z2r1Hs48ybbDJvA7SyGhidLhRV2vPocDxKx06doD4of/+mYwVZTuVjp2LreQamdQW/91WswXNt82YRhwYxAAL4WliBEe2nwZfOPR5M23t5MHXrZrb+HHXZf7iZ5DrySWpdDlxk+4CYUYXVj/IPq/770Qau5eaPCuOJ0Fs6s4TL+/Zq0e7IX+wb+Hs8rnHvejsliPhLTZDSwj06BVmPQbyPdsOK3ymRh8Q4UB9MkAIhM0Yyi+jSDaKi6xaayYW7Cdk4kT33fsM1eVJEK9PHZDSMz+2vbjDXY9CHJ/ylgX/BLxO+HfGi9Uja0lPAtn7LuiRXrAu8IShb45iQ3E1/5vy5TOIB2OaX0mRVgZLy/AA606ssog7EUVnJhWDRJ6RJ8krpcdPDFVH+rv850/X1k+Uh3ob8ng3XPzAfp+q0Az8N/O0qsWPIWPxdO/fnUBXOJb3uiQ9M3cwKRfqxk44UxNnnP8xS9VK1l6XhxVlZ2bEc4p1R644EfTgCgFG48OdKZMlqnAnwhUfdnPMnjT286PUbGqgeuVpiepFgXiSBNt+fsvgm+fgt6w3xq3/YLSGtu+
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbf31bb-9701-4efe-c04d-08d804ea83bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 22:40:54.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLU8DgEmuKQPF/VqSao2PDoaqHVIZy0VA+rl7uamuSx+NgnXazdQQ/oKZngmqsNFBbGB2k8jIfOpdUDffW225Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogRnJp
ZGF5LCBNYXkgMjksIDIwMjAgNjozMyBBTQ0KPiBIaSwNCj4gTG9va3MgbGlrZSB5b3Ugd2lsbCBh
bHNvIG5lZWQgdG8gdXBkYXRlDQo+IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0LCB3aGVyZSBpdCBzYXlzOg0KPiANCj4gCQkJRm9yIFg4Ni0zMiwgdGhpcyBj
YW4gYWxzbyBiZSB1c2VkIHRvIHNwZWNpZnkgYW4gQVBJQw0KPiAJCQlkcml2ZXIgbmFtZS4NCj4g
LS0NCj4gflJhbmR5DQoNCkhpIFJhbmR5LCANClRoYW5rcyBmb3IgeW91IHJlbWluZGVyISBJIGp1
c3QgcG9zdGVkIGEgdjIgZm9yIHRoaXMgd2l0aCB5b3UgQ2MnZC4NCg0KVGhhbmtzLA0KLS0gRGV4
dWFuDQo=
