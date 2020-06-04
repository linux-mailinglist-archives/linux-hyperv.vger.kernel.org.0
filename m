Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095761EED84
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2020 23:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFDVwB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Jun 2020 17:52:01 -0400
Received: from mail-eopbgr1310111.outbound.protection.outlook.com ([40.107.131.111]:28416
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgFDVwA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Jun 2020 17:52:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HapSrbPbg5borr7AY8ru7e2ZZor1TN/kzuM5kRSpfIKvVpydTcmswpaPoJZ/XfcyEALVZ3HofXGtNSH1KLsUBoHw+jhbDiERw9R8oK+g91F+HMWqNKxFwUP4aKdP0VNePTdhTQCVgomymvv3kHAKEd1Hi5CqUKn+MM+E52MQmDtxNSMYM82E9eyEydH9LlrpTW/pbvFVd+djXxXxk3kBDAhRs7NUsjykSgdfpUi1PScyqGIGSykmYZ+ECZoc4M9YpW2qhLrzhYvhVt9GxLf8SAz3j88fSiWQ5ft0x6sdcftyLeHTF5TPkfZ33FbVMGqQVtDh5QZP00nP/leAfDcK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgbFpQSong9zMyNKrndw9f10bGkEuDGfhpKFkPfN2LU=;
 b=cCvbuN43hRhzUWsmFL9Rjz5vgIAzWotZSkKS+FpXXQ0g1n3cC4keypjmKzbOUvEl86CR5Lnfr3fQAvr3YgsNsw6++U7HMlIR8yD/jTcL80x2FslseKF4B9Exr1S0WzWteJn1mfC5jFD5AfvoG4/DU151lFM942Dx9Sw0fdAjvpFSaLkrMoWsO5qxvzbumfN5V6FF3A7vK+pjGxj9v2FKUtremFnx+vtS3tfEx9ohuhxTRLxZqbRU+SnFfKvOYE+6Bbou8kQ96YzW6M+dsMsZzuTCJUIxmC92UPOvN+WPaBbu+08RF3beCsPTLJVddNh1vJEXXPGZrJzeJ8Vhp1MZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgbFpQSong9zMyNKrndw9f10bGkEuDGfhpKFkPfN2LU=;
 b=Pht6nRqIFhTXEqv9lFgmMyM8FuHiK79bFYA9F8LENCHiseBGVa66Se49lv0ISl6V8VBloIBs1yg311kS+eAOVosjLeamiLZCjKEtJcZvpg2Utuq/TcloBKD+fw/as/WKWsWRqQ8RzR8N2S97ylW86VO9uEmnycVc8S5YCW/1I8s=
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b5::19)
 by HK0P153MB0339.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.3; Thu, 4 Jun
 2020 21:51:35 +0000
Received: from HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983]) by HK0P153MB0322.APCP153.PROD.OUTLOOK.COM
 ([fe80::e567:3a32:6574:8983%7]) with mapi id 15.20.3088.011; Thu, 4 Jun 2020
 21:51:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'efremov@linux.com'" <efremov@linux.com>,
        'Dexuan-Linux Cui' <dexuan.linux@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>,
        'Linux SCSI List' <linux-scsi@vger.kernel.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Use kzfree() in storvsc_suspend()
Thread-Topic: [PATCH] scsi: storvsc: Use kzfree() in storvsc_suspend()
Thread-Index: AQHWOrkjuNlCF70aE0iSK1Gft60RkajI/fMQgAAA/HA=
Date:   Thu, 4 Jun 2020 21:51:34 +0000
Message-ID: <HK0P153MB03226BD1374D6FF3B1D545A7BF890@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
References: <20200604130406.108940-1-efremov@linux.com>
 <CAA42JLat6Ern5_mztmoBX9-ONtmz=gZE3YUphY+njTa+A=efVw@mail.gmail.com>
 <696a6af8-744d-01b5-4a37-5320887e9108@linux.com>
 <HK0P153MB03228498F6E0AD292909CC7BBF890@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB03228498F6E0AD292909CC7BBF890@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-04T21:49:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3cfe004-f624-4e11-8802-ac1e1393a663;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e404:4689:ed94:8298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e580886-5b1f-4db6-2302-08d808d17367
x-ms-traffictypediagnostic: HK0P153MB0339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0339FDB519E16E8387E478EEBF890@HK0P153MB0339.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyk6fOqWnVsCS1ZQQg2/yE7PuQpXkWhvVR5/by5YZKsK2ceH5d+QotRjvngATeg0xZC83AGrLp79BrgBZ8pvgbqrzv32z1W+r5d71n9FASQ4f651z9qCQV7YUJc8gIHs4eVhyMQfnmRZb4mnUp8Q9vE7N5oFnYjABiTsSZE2B1R8Phz6fJUpCEwobV1zT6TemdVVS0ZnYuLx8adkGOOkJjh5Y4I171uWCshOcG3vBlpgr5PxVEluKGfKJOBJ3tOVoYEjBiAcjM/Ktq38zHwDAV4mTKgWshH7RAuHKkfeCXBJ7NmXE1zGTLgrcRCfGZkmmwru//4dlcW9nvNzuMeit5LgSJ/2E5N1RyvsSzM3S7e1IdIZpjZKCm91Wc/WgYHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0322.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(52536014)(4326008)(33656002)(54906003)(316002)(6506007)(2940100002)(8990500004)(66556008)(64756008)(66446008)(66476007)(86362001)(9686003)(55016002)(110136005)(8676002)(7696005)(5660300002)(4744005)(186003)(8936002)(10290500003)(82950400001)(82960400001)(6636002)(76116006)(66946007)(71200400001)(2906002)(478600001)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lWsgaIr/36cgFhkggmtD4e5p38WHvAsOHwLvrxD6G+MNroS33uJD2tUSIvcNeOAXOMtHcFYoynbWdjj2g+kcI0HN4P/I91JET3ZiCCNECqptxIF4msQliNZ/b8g5Uw/iFgOtbNxq491cNo0MELSTg1iF9XaH+GGX8/7uI7yy2A9O5PfnLw6POGu2buJky6AASXyr0keOyjfxoeZfD3jh7d+Mf4lIFb3C9P8MXidBthbUgddgtWJoAeVZiNR4DWhgJ0ghq+ijOVOZqCTJWXS6b9KtnyIKoZX+vNlbdK/W+IYNqtx+ReKA2/vAQd2mMvV+WtnB3a7v4Zo2Whd4vg1BpA94uxhzhrhoCW0D7HU0V4cCv2bGMvlTxofdcxuwWfhSWdwrJupfAf35DH/GzTXgBq6EdUs+WarrAGGEMQDy539V2JO7PFkvd9K7k9tyzpjylTjc9KhNnxGEbyXK6cahScMCqCNmI6QusVUObLxdgJ1Y3OYxY3crIKoJfAuUzLeQKKd6ViWmCWBfn7Eu1z9cEUgpP2Unj2SdSOp2oq6tCQkEt3D2xYsRY2R8BKG1hIBD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e580886-5b1f-4db6-2302-08d808d17367
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 21:51:34.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vz5WuyhxATNGteB2tROrh4azo9a/ShAT4kJcyqNHiCjObp+gTeyALMpLB553D91SdhoqzDAWPAI+pqiGO5NOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0339
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEZXh1YW4gQ3VpDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDQsIDIwMjAgMjo1MCBQ
TQ0KPiANCj4gPiA+IENhbiB5b3UgcGxlYXNlIG1ha2UgYSB2MiBwYXRjaCBmb3IgaXQgYW5kIENj
IG15IGNvcnBvcmF0ZSBlbWFpbCAiZGVjdWkiIChpbg0KPiA+IFRvKT8NCj4gPg0KPiA+IFllcywg
b2YgY291cnNlLiBDb3VsZCBJIGFkZCAiU3VnZ2VzdGVkLWJ5Ij8NCj4gPg0KPiA+IFRoYW5rcywN
Cj4gPiBEZW5pcw0KPiANCj4gU3VyZS4NCg0KUGxlYXNlIGFsc28gYWRkZWQgYSB0YWc6DQogDQpG
aXhlczogNTZmYjEwNTg1OTM0ICgic2NzaTogc3RvcnZzYzogQWRkIHRoZSBzdXBwb3J0IG9mIGhp
YmVybmF0aW9uIikNCg0KVGhhbmtzLA0KRGV4dWFuDQo=
