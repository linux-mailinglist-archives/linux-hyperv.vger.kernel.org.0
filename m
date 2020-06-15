Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4F1FA0C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2020 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgFOTuJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Jun 2020 15:50:09 -0400
Received: from mail-eopbgr1320111.outbound.protection.outlook.com ([40.107.132.111]:14152
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728771AbgFOTuI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Jun 2020 15:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8sOZckIwcnroXpDODSas9Nn8tU+l8TK9W219JJbyYeb8iWoxFNguaufjYWbisxPJlAUTRTyz5vlg493tlPOlMxvk3tbAngOURjWcfXPbGrLBuj9Ig+zPPZMAxMZSQqLqhSZn8r0x32Ur5e/th/Ars9OBnDFOTz3/D+nZwxAsrdLmqptvbbcBbgc3O0D8ibRvaNh9rn/UiaeZ4eXkvmDr4XVo0liuAj3+Xd6TMj8IX8vWpTFS16xfLmXAffq5QoDR6bJfRAtakqQq0idfkDkTnyiXL6qBLPH9NlJjClwUiQtTIo4XvjOAdBJDsRTxjBROokZlsvkpaEe8A2S0Tr70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSOQd/xufemNouxDDAL6ie8h1biX7tlYTecaGVirdTc=;
 b=BYnARryJzrXMHjNRJJsre52slDvejBTZG2wv8gQ3j6kyLwQhrGrP1XXl367mRHS0gYnKPJ17TLku/w3TOtYYS0jHGnaLhA4D5loBVm3ruUlWGoRc8g7Q93esu23eMWoFPb0oR7I0hHZilt0x4vnTWaMOi7IY7V6qdp3c5ovPCYrEH4wYCbLMw91xyAARW0zRlKsH+szZDuSuKGdQKeJTrN+0eFF+9giy2vqf/4V7+Z5TrEG4Jy2cnYXyLNqbPmO1blv0HVbv/3lTKZl1ZTtAnh7AfOJA9xuOKWULIuiUP69Cs3UkJZcYj9t1Bvh9JfjLG0JbcE8AJOKH5Z6hPIQuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSOQd/xufemNouxDDAL6ie8h1biX7tlYTecaGVirdTc=;
 b=HsyN345v5YDHgbNquXdQM5vQDtJis0d+YQhDtKI/Enld69CVK6lwH4x7tvlbgxd76IAHdG6bszHOznnvQm63e31767gEMAjg7a4m14gKOSi4GxntL2v7H4sQLaPo3gEhA3CaiOX91nJg8UVj44pnw89GR+fgMP9viuj76d4SD+E=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK0P153MB0193.APCP153.PROD.OUTLOOK.COM (2603:1096:203:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.0; Mon, 15 Jun
 2020 19:49:42 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983%8]) with mapi id 15.20.3131.009; Mon, 15 Jun 2020
 19:49:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: hv_hypercall_pg page permissios
Thread-Topic: hv_hypercall_pg page permissios
Thread-Index: AQHWDR+7o7IWH4OD3UKrKLNTyqpwjqjU/2DwgATGLoCAAJaLQIAABMBA
Date:   Mon, 15 Jun 2020 19:49:41 +0000
Message-ID: <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200407073830.GA29279@lst.de>
 <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net>
 <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87y2ooiv5k.fsf@vitty.brq.redhat.com>
 <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-15T17:41:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d684f98c-067c-4200-9ca7-0624449fed1d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:b8fb:6bb:502d:341f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 751938f4-bf7b-40bf-2278-08d811653f0f
x-ms-traffictypediagnostic: HK0P153MB0193:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0193789259779450861E3380BF9C0@HK0P153MB0193.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+47VV1IsS4nFSNa0w2kl1ZkJtaDqIvR2zJX6LEbB1EakQVEHt6I3EjvEwvYDp+IZisicjjN1FKQFrI+3SUwWXJjYAfLOalkFpo5K7NWh9pd3xxz2X8PdlDtYExZFgnQgFkmgu9MyK50yHqJlmHKKHqli3URcgvWlJ7w9Aa2nGmjW7XhNfP+3Gsjc42yRPmgL1MvNv94RExHAgjaet6DorupAcZhKEMq0dfGhhKrtshGlTHovP7k+YGhLb3j4yEm3jtZQgVkRuv07HCAyVY3ku78SSesDf09aMXuKYvaBD+LFPLTI57mL3ziq5kHp/yd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(7696005)(71200400001)(2940100002)(7116003)(316002)(86362001)(82960400001)(54906003)(55016002)(110136005)(66946007)(66446008)(64756008)(66476007)(66556008)(4326008)(76116006)(8990500004)(82950400001)(2906002)(10290500003)(478600001)(8676002)(6506007)(5660300002)(83380400001)(107886003)(33656002)(8936002)(9686003)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nin5UcePanvVj8411XcrAJcmV4jPnXilJUtI8t557FLtP4z0LUhpZwU15+srMxfKZcBBtaZGcQLxc1fHFGCEvYezDrpT6bvFnNn97EcMq5wlLgrFD0Ie749Qu+5rQowBeFMc2j+NM2jwhG5mv9Qo4CcpLsJDhZa2gGjZw7oRRqn3tcpNvaAYQoNa7nwU0CCTsrQBnqsqfcX2rHMeAJv6S9SfpWTxpid+9Y0UEMTVn3Ol0xwkMZE0IAujsiQuziS0LJS9QOOjS/0NxLol+Q7J/qBtefgFFNsxeJTSsR26rS2o+qBCpaTd1mf14FOXdzqkkTnk9osbtrwZkUt8MTLCXZ5qf7bJI0eI/W1uAK0dEZYXZqV5cwR6MpoYntLVEFtFo1w3oJQBF/u7d24D9D254NU6CwiDnRdaiBfNAy+98AHhSYlpN0tr6CJpwwgsQsTCp4yyWKG6kQqTJ5xylF8kxYPYgxBJ+wzf0WAeZOZ7Y7UoYv9HgRU+1f8szChKz2aDtcKQhY3+2NiFNQsi0p9Nk86gs13CB/lEIhy1kxFo1Gw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751938f4-bf7b-40bf-2278-08d811653f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 19:49:41.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqEpTXUhjWAIPyhWCIPxV3wLPJBnS9m2VylJ0Ls6ImKaMmlyYtK/hOw4ngVk9LMZ54+P2g7XBZi1eE8JNq3KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0193
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+IDxsaW51eC1oeXBl
cnYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgRGV4dWFuIEN1aQ0KPiBTZW50
OiBNb25kYXksIEp1bmUgMTUsIDIwMjAgMTA6NDIgQU0NCj4gPiA+DQo+ID4gPiBIaSBoY2gsDQo+
ID4gPiBUaGUgcGF0Y2ggaXMgbWVyZ2VkIGludG8gdGhlIG1haW5pbmUgcmVjZW50bHksIGJ1dCB1
bmx1Y2tpbHkgd2Ugbm90aWNlZA0KPiA+ID4gYSB3YXJuaW5nIHdpdGggQ09ORklHX0RFQlVHX1dY
PXkNCj4gPiA+DQo+ID4gPiBTaG91bGQgd2UgcmV2ZXJ0IHRoaXMgcGF0Y2gsIG9yIGZpZ3VyZSBv
dXQgYSB3YXkgdG8gYXNrIHRoZSBERUJVR19XWA0KPiA+ID4gY29kZSB0byBpZ25vcmUgdGhpcyBw
YWdlPw0KPiA+DQo+ID4gQXJlIHlvdSBzdXJlIGl0IGlzIGh2X2h5cGVyY2FsbF9wZz8NCj4gWWVz
LCAxMDAlIHN1cmUuIEkgcHJpbnRlZCB0aGUgdmFsdWUgb2YgaHZfaHlwZXJjYWxsX3BnIGFuZCBh
bmQgaXQgbWF0Y2hlZCB0aGUNCj4gYWRkcmVzcyBpbiB0aGUgd2FybmluZyBsaW5lICIgeDg2L21t
OiBGb3VuZCBpbnNlY3VyZSBXK1ggbWFwcGluZyBhdA0KPiBhZGRyZXNzIi4NCg0KSSBkaWQgdGhp
cyBleHBlcmltZW50Og0KICAxLiBleHBvcnQgdm1hbGxvY19leGVjIGFuZCBwdGR1bXBfd2Fsa19w
Z2RfbGV2ZWxfY2hlY2t3eC4NCiAgMi4gd3JpdGUgYSB0ZXN0IG1vZHVsZSB0aGF0IGNhbGxzIHRo
ZW0uDQogIDMuIEl0IHR1cm5zIG91dCB0aGF0IGV2ZXJ5IGNhbGwgb2Ygdm1hbGxvY19leGVjKCkg
dHJpZ2dlcnMgc3VjaCBhIHdhcm5pbmcuDQoNCnZtYWxsb2NfZXhlYygpIHVzZXMgUEFHRV9LRVJO
RUxfRVhFQywgd2hpY2ggaXMgZGVmaW5lZCBhcw0KICAgKF9fUFB8X19SV3wgICAwfF9fX0F8ICAg
MHxfX19EfCAgIDB8X19fRykNCg0KSXQgbG9va3MgdGhlIGxvZ2ljIGluIG5vdGVfcGFnZSgpIGlz
OiBmb3JfZWFjaF9SV19wYWdlLCBpZiB0aGUgTlggYml0IGlzIHVuc2V0LA0KdGhlbiByZXBvcnQg
dGhlIHBhZ2UgYXMgYW4gaW5zZWN1cmUgVytYIG1hcHBpbmcuIElNTyB0aGlzIGV4cGxhaW5zIHRo
ZQ0Kd2FybmluZz8NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
