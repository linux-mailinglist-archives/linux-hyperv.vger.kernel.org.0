Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160E41B6C11
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2020 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDXDpb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 23:45:31 -0400
Received: from mail-eopbgr1320094.outbound.protection.outlook.com ([40.107.132.94]:34944
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgDXDpa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 23:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz6pZSIPfQ3GDCggNOuDPMwq1O0FvNTz9Yk6i5vJVwDNRVW5o6TO6gtYpVprNFLrUWYaIhYFr5caYO8MVEMJ4oeZRjmIqMrrMAik0PPxGvacZB02a0G3PQkxP0KcEP9NTS7TxRDf0JFoTRM2q+O7VvuKVRa2+YrfI9Vh5HT0jBsdDcFFf7yI+dGDjtBOi5B86YmxNruaH2ZNdEXkaKQWTQxqmSCu+Q2bDYEw3UfyKN6Okrt9b56NFu1Rd72jUOnVgCRbHsXqMVyOvzqvMGbReZCd1kE3oFbgcojxqUDgRrTsLYQPGdHMOd/s0Sxsofg8+zOIcNE7hZ9uEsrjH9kRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eMjA3+rE3rSAJpziH8adWm+ScPXgNnkL2XGxj8JK7Q=;
 b=NM9Olv9UPPdl47oFFarWX6IZOkYJP0ty05KJuZwH4im5jKt0lk+9PkKRluPMbTuUrk0XO59pQVEMx5kjY2VAT8JHhwoRnMpMsiXbajjC0g+Lp4dK0FFgCS1euU8syaPFnR15N56N+Bx9bEPYj42ZmtPP9pMyQR/lz2j2fzrBHPEpiaqnkYpH6Irs5XvRJudEh1WEFeOLYvIcNxTvWFa+R1sCyl7/Snsh4FidFCJLvI55gBGy6/ex9DN5XghXpHA1As0CjHPo4xpIBsi9DYnIrEwFOdlb8jm50Rp8QjveAGL8HX1IhC3hwmb8QkRlgqGj/d571mcRVGmJv2NDmRtuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eMjA3+rE3rSAJpziH8adWm+ScPXgNnkL2XGxj8JK7Q=;
 b=N0UlAW3jmXWZa5/Vtz2xK9SppJiyaaZWmGDWpfQsRME/GGak39ygfrqjymZGZpreu1kRE2Fry6C0/uJ/tKJRAHOV8TuGJ7iUyt9tGPmhunmhLoPdKIpKW5dm7vl3ygkcekQKq/fvM8TgB/U4cmkh/MVfLFkGz4lb4hri0l0FHX8=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0098.APCP153.PROD.OUTLOOK.COM (2603:1096:203:19::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Fri, 24 Apr
 2020 03:45:20 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.010; Fri, 24 Apr 2020
 03:45:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Balsundar P <Balsundar.P@microchip.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGGMw6DFeJK2tFE2eFTHRpRyDH6iElrSggAD4nwCAAKqbQIAAsEKAgAAFkoCAAGxVgIAASErw
Date:   Fri, 24 Apr 2020 03:45:19 +0000
Message-ID: <HK0P153MB02739E7D2F3618B7A4791593BFD00@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
 <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <c55d643c-c13f-70f1-7a44-608f94fbfd5f@acm.org>
 <HK0P153MB02737524F120829405C6DE68BFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <ade7f096-4a09-4d4e-753a-f9e4acb7b550@acm.org>
 <HK0P153MB02731F9C5FC61C466715362CBFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <f23cb660-13e4-8466-4c78-163fcc857caa@acm.org>
In-Reply-To: <f23cb660-13e4-8466-4c78-163fcc857caa@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-24T03:45:17.6687787Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=01c1e47c-3cf0-4592-bed4-7f8b4134f98e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:3421:d362:4eed:46b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a227e30-ef49-460a-e941-08d7e801e950
x-ms-traffictypediagnostic: HK0P153MB0098:|HK0P153MB0098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0098A7E29F4D9F1D5B553129BFD00@HK0P153MB0098.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(478600001)(186003)(9686003)(4744005)(7416002)(53546011)(86362001)(6506007)(316002)(10290500003)(76116006)(110136005)(54906003)(66446008)(66556008)(64756008)(107886003)(71200400001)(66946007)(966005)(82950400001)(82960400001)(7696005)(33656002)(2906002)(4326008)(66476007)(8990500004)(55016002)(8676002)(81156014)(5660300002)(52536014)(8936002)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIT/YLukXy6fBZCo85ITaLdSuDRVZBPXmG2vpbu70V/zQn1i6vxijjTCJM/q0FG0qNAba2imxH61QUCWezYqW8Ihl/ezz7QR74vvItgsNv0NZ7iSCA/U7XpNDUQCYeWLsoctmC4L+1E4NFkeUHSxgVHgoWTLwQXvWoQQin+Bd+LlgxVZziOaZturo6VyM17nClQKLTse7VDMl9ZtG6V5ybaUMagtxNJXm90PA80PFqg3T05eUMNbgpEr3wzUSHrkcq8K1IocIQGo7HQQG0ZnBx0vZBQBnhSdXXtUt7vrrv6vrTSbtyteeuKmTHnrkDU7u5ZsrkreludpzH/lnZJXl9fBsucRLmc7+YYNGNgDLSjQloqhAwKTVV+MwWG04vUvF081JHt/mWW0QIURCqJ8/H65c7QomBgWPBgzjVrRh4adXstL2WYPWTxetJaGTkfX6Yix+qtwbtsoXdeMCamZ3yV1nfx3cm+K7BIonzwwMgdQcjD8LvuvyEk/KInmKjlVQyE4zoS4Ucqv7AeGR5TqfeYD9wfyQ4WUpCxYlYkOcSSPL+gqMvfgkI39kghmDYcw
x-ms-exchange-antispam-messagedata: Ht38ie0UzZW742LNoV0DricOpSlqsWOIBEnWQBX4Nh3opJw6o8Y8oqczq7zWx77xrStmo8ENGgD7dPrpAYoztIqoMPgf5C0oQr4r0scO5ma7MlsgmI+xK8IP4MX5h0dNsawHtzimU/To1KAWg0P6mFlE1Hi/v3wuQmyit20irxvw6XkTigddxHghvKV4YXiuwT6m9jA+rkNH6suC0gd6Eyj/Zffd8GTqU2TD2a690v5eEcBaV2oljkDuxcPCrHtF8FGrdzuLIABmL29qfo42jzqjAJkBt5FptsfUnBsAYPQC+POecFpLhAKb4iNp0QpfHgxr2H1v8y11/z9YN6NzT48v2dQ5DAG1pEaeHWmLwrg9x1JjLTqyysYEj+Q914924Igm36HKjlWwUEZoqhcYoIsFCTdeSoc5GSneJAunZtbbd6lQTvZItTqpT8gBQFq2x6m+9FhTW73BVfO4pRdz8KA6AXWH2V3tZKhvaL4QLOBxs6c6GHYInci9G1HKU0V0EYRqtuJ1Casp7G0ueTunLM7cH7YHVFsDkzB4qKIsi/MKUeGfzzmM4thWEczRxI6FAMDrFVhaatQVWI7dwsQOB1J64SAw5bybnDhbor8E2Aj3UEJQL9iIRR0IJyiUDVYj5x62Xqa4Rvubb5FJXdOEpG7RI8DYLcC3MfN6fOvAumPfu+OZxVvMk70XKneeEUHBU2cXJCxaa27FvHxY1x63WznMG2gqleOo5osjw0xhc4dMoausofi+4KhD0tRuqPp5r9TC/0yL2X2892yLhMkrrlDQqPdqVWa/mTQdxEv84d71QHgAPlB4AOhPviP3O0A9o7j9+Mp7kKRxm7q6gX5QZ6nM967zOiayoGMR3FUgeu8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a227e30-ef49-460a-e941-08d7e801e950
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:45:19.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/ozbkpLtU0m0vYjmeeqcv6D8vPklEfwH8nWsyo05eSW9H8VexCkGBpokMErQfospJbj+fFqOW5UQJopZv5akQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0098
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDIzLCAyMDIwIDQ6MjUgUE0NCj4gT24gMjAyMC0wNC0yMyAxMToyOSwgRGV4
dWFuIEN1aSB3cm90ZToNCj4gPiBTbyBpdCBsb29rcyB0aGUgYmVsb3cgcGF0Y2ggYWxzbyB3b3Jr
cyBmb3IgbWU6DQo+ID4NCj4gPiAtLS0gYS9rZXJuZWwvcG93ZXIvaGliZXJuYXRlLmMNCj4gPiAr
KysgYi9rZXJuZWwvcG93ZXIvaGliZXJuYXRlLmMNCj4gPiBAQCAtODk4LDYgKzg5OCwxMSBAQCBz
dGF0aWMgaW50IHNvZnR3YXJlX3Jlc3VtZSh2b2lkKQ0KPiA+ICAgICAgICAgZXJyb3IgPSBmcmVl
emVfcHJvY2Vzc2VzKCk7DQo+ID4gICAgICAgICBpZiAoZXJyb3IpDQo+ID4gICAgICAgICAgICAg
ICAgIGdvdG8gQ2xvc2VfRmluaXNoOw0KPiA+ICsNCj4gPiArICAgICAgIGVycm9yID0gZnJlZXpl
X2tlcm5lbF90aHJlYWRzKCk7DQo+ID4gKyAgICAgICBpZiAoZXJyb3IpDQo+ID4gKyAgICAgICAg
ICAgICAgIGdvdG8gQ2xvc2VfRmluaXNoOw0KPiA+ICsNCj4gPiAgICAgICAgIGVycm9yID0gbG9h
ZF9pbWFnZV9hbmRfcmVzdG9yZSgpOw0KPiA+ICAgICAgICAgdGhhd19wcm9jZXNzZXMoKTsNCj4g
PiAgIEZpbmlzaDoNCj4gPg0KPiA+IEp1c3QgdG8gYmUgc3VyZSwgSSdsbCBkbyBtb3JlIHRlc3Rz
LCBidXQgSSBiZWxpZXZlIHRoZSBwYW5pYyBjYW4gYmUgZml4ZWQNCj4gPiBieSB0aGlzIGFjY29y
ZGluZyB0byBteSB0ZXN0cyBJIGhhdmUgZG9uZSBzbyBmYXIuDQo+IA0KPiBJZiBhIGZyZWV6ZV9r
ZXJuZWxfdGhyZWFkcygpIGNhbGwgaXMgYWRkZWQgaW4gc29mdHdhcmVfcmVzdW1lKCksIHNob3Vs
ZA0KPiBhIHRoYXdfa2VybmVsX3RocmVhZHMoKSBjYWxsIGJlIGFkZGVkIHRvbz8NCj4gDQo+IEFu
eXdheSwgcGxlYXNlIENjIG1lIGlmIGEgcGF0Y2ggZm9yIHNvZnR3YXJlX3Jlc3VtZSgpIGlzIHN1
Ym1pdHRlZC4NCg0KRllJLCBJIHBvc3RlZCBhIGZpeDogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MjAvNC8yMy8xNTQwDQoNClRoYW5rcywNCi0tIERleHVhbg0K
