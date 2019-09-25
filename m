Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA49BE607
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2019 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbfIYUDI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 16:03:08 -0400
Received: from mail-eopbgr1310110.outbound.protection.outlook.com ([40.107.131.110]:39456
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729118AbfIYUDI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 16:03:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku/ukuqZVNaV7/XV4e+XtgNhpTSIEQU58qZihSEp4bNS0omop2t+9LCykYdFK1a52t6+tgRqErOUvWxi0L7i+AUBzpygsp3JJnn1qImitexP9ThR9+AehbsQc5oaP1Gi5HuYahi9Gg3jXU8UqcKD9Yp9z0idSC7RZk+nrqNGYojW9fx/OV5zHnzZT1cZVg/XF6pW4TQ3GqGcSVfzXpjPY+UMcZ5rhxttoSYm3PpJYd2gXukhFgjIaOgwVbU1sTedHf+US+K2kClvKFO8QJPcP1ZiZDILWxGxfUwqHy182lPD5TYGpNQfke6g6kOStXiiu/Kp1uh1vkY84o7Xmalk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pERnnq11T2DEfVyDb5Xo3s7tcIAhZRt3YAUJu2xSv8=;
 b=BLLNqwsx6SycZ1m4kjmfHdS3FG9GG0x8B8hE9DjvuAZmHoNHGg+9ZKpKV2BUVKoqZII85NbQ1qrB2ZeQrjQyJeVuGD9Jh3VCh2GWmbf2jrtgJTmvlNgw70H/V29ss/SIFsHDg46dagohdXAhQmxA5vj6PlqQkyIcuaiGPk/NaP7tLB1W1wLbD/Ye1CYyFsFVqyLzjMIPCb9L4XyrC/NdiKthvloKdW5G7o0a+cBywh65+V3EblMywHut02yA+yzRXst2uAffN/QyGJsHQNEY8tjc0CSrMbZzvOpnIyerVXeMh8BkojD4PzhOn+qvTq4hVRtR0T8+8z7qp4SEeUP+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pERnnq11T2DEfVyDb5Xo3s7tcIAhZRt3YAUJu2xSv8=;
 b=J2cnVIpqfILl97crz+PjdK9xzwsxANXR0fzpWDSmyB8pqpfpHKM8dpxSJSLobWlKFGuLVtURrTL1Q2726/Yv0kKslmQIaREyyn8uMxosGDObdjrD458CR9ok564xr7lkuKhJ2iAgtGJGqTT9JLtKC4PoHbr0BNaj422TurR/jI0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0202.APCP153.PROD.OUTLOOK.COM (52.133.192.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Wed, 25 Sep 2019 20:03:03 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 20:03:03 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] hv_balloon: Add the support of hibernation
Thread-Topic: [PATCH] hv_balloon: Add the support of hibernation
Thread-Index: AQHVaVISraz6+BtHYEamhMlzHx+g16coS8YAgADwLwCAAMMQUIAAJyMAgAAQlQCAEq5eQA==
Date:   Wed, 25 Sep 2019 20:03:02 +0000
Message-ID: <PU1P153MB0169B05143A68A56740669AFBF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245010-66879-1-git-send-email-decui@microsoft.com>
 <42de5835-8faa-2047-0f77-db51dd57b036@redhat.com>
 <PU1P153MB0169E922DF7A5A43C7026D82BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <7d218fd5-76d9-f5fa-548a-76fe5dfab230@redhat.com>
 <PU1P153MB01691EC455AAF37BC6AF26DDBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <ef6f8554-8324-a4d8-4549-759495e482b7@redhat.com>
 <PU1P153MB01699AB87526B16F7AB94045BFB20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01699AB87526B16F7AB94045BFB20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-14T00:26:00.3261188Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cc25ee78-8be9-4480-8628-176a5590891e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4755c50-d20c-460c-252b-08d741f35f8d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0202:|PU1P153MB0202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0202AACD9A341C0ED4DAE4E1BF870@PU1P153MB0202.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(14454004)(76116006)(55016002)(25786009)(478600001)(6116002)(9686003)(6246003)(64756008)(66476007)(7696005)(6436002)(33656002)(5660300002)(10290500003)(66556008)(66946007)(2906002)(6636002)(86362001)(52536014)(229853002)(4744005)(2201001)(110136005)(11346002)(316002)(99286004)(22452003)(486006)(8990500004)(476003)(446003)(6506007)(71200400001)(71190400001)(66446008)(10090500001)(256004)(8936002)(76176011)(74316002)(305945005)(186003)(8676002)(81156014)(102836004)(2501003)(81166006)(46003)(1511001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0202;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8wbtNvcoPeZfSo+uSIn8aO+D8RSwIOml20FuQQH9POdfYYlAzBEusYwsVRHyKkMAs0yjTvgRjDouJWq/L5l5y22uCZij1qSiLWBmq0ssS/Ht1AgyoewfgWLeq6Y6kZ9WNE92Su/ZQ8maSHR2kezyX8gftoYf7sUgs4dSzTwavUAuYXVFZzpVUJEVwXcpx+fLgOPPP+re0k5if7dNGKqTYBG1punZexkzniwA2Y1xSIFmAm3XLgxfb+C1pWODwmZWnSYvPnmbyOKj8hwZdWBnl5+HZ/UIKzy43SahDnJg9L74VtwH+1aUt0Jn79k/0m5RBVxS0GNKPX2DoeOC7SgKUPjy0p08e41e4HUKYoDVaBMWbQgOhEdUrdrDJWUfaymUvu6X1akvUp+p6l5wOcALpTQU5rUlB03OZLROsnP4R0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4755c50-d20c-460c-252b-08d741f35f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 20:03:02.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOPfF4m5XhdZfroVL0GsXQQfAMJlxrpHr8zGJIGBJCwVDv+C2YNuGojk3pOPK5xugJZeMahoSBR0J901XmtcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0202
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+ICBbLi4uIHNuaXBw
ZWQgLi4uXQ0KPiA+IEFueWhvdywganVzdCBzb21lIGNvbW1lbnRzIGZyb20gbXkgc2lkZSA6KSBJ
IGNhbiBzZWUgaG93IFdpbmRvd3MgU2VydmVyDQo+ID4gd29ya2VkIGFyb3VuZCB0aGF0IGlzc3Vl
IHJpZ2h0IG5vdyBieSBqdXN0IFhPUidpbmcgYm90aCBmZWF0dXJlcy4NCj4gPg0KPiA+IERhdmlk
IC8gZGhpbGRlbmINCj4gDQo+IFRoYW5rcyBmb3Igc2hhcmluZyB5b3VyIHRob3VnaHRzIQ0KPiAN
Cj4gLS0gRGV4dWFuDQoNCkhpIERhdmlkLA0KSWYgbXkgZXhwbGFuYXRpb24gc291bmRzIGdvb2Qg
dG8geW91LCBjYW4gSSBoYXZlIGFuIEFja2VkLWJ5IGZyb20geW91PyANCg0KVGhhbmtzLA0KLS0g
RGV4dWFuDQo=
