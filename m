Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DCE1B4C5E
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDVSBx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 14:01:53 -0400
Received: from mail-eopbgr1320094.outbound.protection.outlook.com ([40.107.132.94]:27520
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgDVSBw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 14:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2E2zHlqQRStBHoXs81kSiK/FAoxzMQpQCB3VogSfRo6gsFtq7h1kHzilH0HpS5dqWTDDAMGvRpKvgogI7Nqi3gnxuUFEQuiNVqunbYEN3XiV79B1ybxNDUVS5D00N0HqfAUeVUBkG8qYkqH/xBUOqBPeLmmZ8rN5nhRz5SpiG17mA+OHxh/UaZvJZ/J60lNLjFTFYKZgGj3haFZ9CP17mTUY3goi0Lr9coNLiHQ/Vk/6zvZd/ayhjVUkyqf1x5XI1cu0RtFUG1go1yLrnBih2rJtaZG6KZN7UDXXVB3EkW/jY2kS2s+bIMQPHuBTeVbu0PTMqWbNukSHkbDKVGuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC/qWeAtGErnkWKpFYPQl8OHH2WdVAPY/Vf43+Mkq/o=;
 b=VBIYFkiaE1L5mbOxsTQ2eexhmT6D/Ovsq7mFg6aN/dtB0EHCEFSFv51xaMTjOJRh6uKXnHGoNe++5+i/w3o0A6QgJdnszxtMMIKofjyuEcWQB8Oc8dsax6oYE9WC8Fmvq4RRleTrK1WiTYrBhCRSY+RgjKZWXIB6QBMIR7UpW8y0V0VNKrWZFPeHI9/pT+KXK/iiKj/OOz1a1cCNnp39lbeZoXIkVRrqpnfVvh5KJ4Gt72CjBw+mp2ZfQNQWoq8MfPyshSxlSg0m1UWo5mZa+4ItxYcsa35sUNE6oJtfybgkO6mqJBAEgTBPSaAUirivIQfZeBvyTDupkdSElH2BnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC/qWeAtGErnkWKpFYPQl8OHH2WdVAPY/Vf43+Mkq/o=;
 b=IPfU4yf1MaHYAoG3aCgkjT8mUJZlYwC8eJQMbe/hqru1ACsk42bWzx6ixNluQ74qiqIUDTOMCzcOX9GI330h+weQrErJAusmpRc9y8iDAvc3th+B90cv6wWemV1GXPi4CMrGINrcpWWPEdqimvsDoDZ3/ZvtyORzC41Mwbeg9uA=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0147.APCP153.PROD.OUTLOOK.COM (2603:1096:203:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.3; Wed, 22 Apr
 2020 18:01:38 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.008; Wed, 22 Apr 2020
 18:01:37 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGEVb6DFeJK2tFE2eFTHRpRyDH6iEXZcAgAArmvCAAAOn4IAAUhWAgACLYPA=
Date:   Wed, 22 Apr 2020 18:01:36 +0000
Message-ID: <HK0P153MB027315BB6DD813888E073664BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <20200422012814.GB299948@T590>
 <HK0P153MB0273B954294B331E20AACB41BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422020134.GC299948@T590> <20200422030807.GK17661@paulmck-ThinkPad-P72>
 <20200422041629.GE299948@T590>
 <HK0P153MB0273CF2901E193C03C934A47BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422092351.GF299948@T590>
In-Reply-To: <20200422092351.GF299948@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-22T18:01:33.3288494Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a78e7ce-7376-4fa2-a226-987ad21aa83b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:25e7:ea9a:b4e5:a1f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c71d91af-fa71-4ab1-4d6b-08d7e6e733f8
x-ms-traffictypediagnostic: HK0P153MB0147:|HK0P153MB0147:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0147E5D5C656B68D3110F4FBBFD20@HK0P153MB0147.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(81156014)(54906003)(71200400001)(82960400001)(8936002)(8676002)(6916009)(9686003)(316002)(2906002)(186003)(52536014)(5660300002)(10290500003)(6506007)(4744005)(66446008)(64756008)(66556008)(66476007)(66946007)(7696005)(55016002)(478600001)(7416002)(82950400001)(76116006)(86362001)(33656002)(8990500004)(4326008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QD4fTLL2nYsBX4uyNo5Ie05t8KabPlD59e9iLeIoqiumwNBka23ZgbOUQdy3QJBS5N6dT8Ka+GS8DFbaoth40tXqjMJcF3a80uRa1rWGLCvtdXHBTjVuP1zmio1ePYHLViv/CGq1DPXpM7qYmAW0D1icM1fjGkw5r+bGPgRzFrVjBNgzmMfi27OAULSWdUYlMZqZHoyg8vNQZlmsoDI2eXRZ2ReK8zt/hFzhUx5mAG2EcROPwxoS1RS65gaJZKjKsJIMDh87zNkyNaI1u21um3AJi0QHo0P0OTRcZ0bcRl04x6VpGrfgxNlZCB/CBf/5BEFqHYTPf8Pm38NyiQ2hP7lC6XocHTaXmX3E8HBvaj258u4sR0Pky25ndbSe/z1ZX4AejRteSoXibHb5Fn4IbeTjgwDyO9jk228Vr4OcvgMeoZnD5uylrRD7UiIT8Xk3
x-ms-exchange-antispam-messagedata: orcnkWWvAsVDFWOW6f9Rf84QCt7izfp8hh++QSMhdrXNL4setBLZtBDOl6sL+iGuf70WCBbbhYss+oPvpTPSNO+UkaqXY2KmgGFoPBfCe6nGTgW4zJF/D+BfWy0UDDKeX+b1cPpn5aJKhEkTTOvAe4AxF/qQCB/WtL4ZcDobxVjsRqizDEHALGfiqYVycBbnozT/rTmVjo0sa348Q0qsivpmO1M05QB2Kz8fWSETtUEL1D1nhgAsUDlmffB/0WaUVpfrB1YVqqyq400TFYCcTRpZWe+52M3HuoI4D+Eeyq5rvgWcJUqcplJAfA+pb+ZTRWt6Z19R7Tvvg59nTvA1ZWP2kkzkxu0lNlmNiR957KYjZDuboZ4Gml7VQzRva97UgsN7qHtI9l0S1hIF3ar0zdaq39tGJPQ47vF5cRoLakAOc/jX/P/vKT7XqZ2xeNamuTUlF0U4OHM1yi09vu/YbjK/s1Pm8FPNfR2kWLMxl8kPjg34GsiMVFft7CgNwUyzogWCtbPPSPYajGiWotpQi/qOLP0R3qgElPqsS6LTgOew6KNEN2Gi2VpGBbcwf8seY2poGN597JMskDlRKXmL9qhQgeaGa0WWhgNvzhrkjBOMhX1J/ViBwi8TzXS1+VVL+8zSM0/kffOrvv9eQaNw30Ev0e3uzueqP9+nw1MUI2IyEGBtc2ipvHRU/kCdNguYc3Fy3B26lVxsmoCI+2/yTtCiJq85e4arCcjhbKloNUez/jJJD5rjAvbPZVh1L3KDB8O1koAHyrU8Xd1+eAAAeG3XHcVzhjjZvYOth54ybXId6ZULAqpAmDX2VMoC2w/pnMWOYmFWvNvp7p3b78BpExhhdig0wkmPmncM4F1OwYs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d91af-fa71-4ab1-4d6b-08d7e6e733f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 18:01:36.3628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pm0CdwY+O7sr5YGCUzkyXVYRUUU4ZSogpJttWtBzzlMxKyA0Bmr5ZQWLlsSew7Y5oma54zMgMtp6d0s9lbeaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0147
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Ming Lei <ming.lei@redhat.com>
> Sent: Wednesday, April 22, 2020 2:24 AM
> > ...
> > storvsc_suspend() -> scsi_host_block() is only called in the hibernatio=
n
> > path, which is not a hot path at all, so IMHO we don't really care if i=
t
> > takes 10ms or 100ms or even 1s. :-)  BTW, in my test, typically the
>=20
> Are you sure the 'we' can cover all users?

I actully only meant I don't have any performance concern in this path
storvsc_suspend() -> scsi_host_block()  :-)

Thanks for your effort to improve the scsi_host_block() API in the patch
[PATCH] scsi: avoid to run synchronize_rcu for each device in scsi_host_blo=
ck.
=20
> > scsi_host_block() here takes about 3ms in my 40-vCPU VM.
>=20
> If more LUNs are added, the time should be increased proportionallly,
> that is why I think scsi_host_block() is bad.
>=20
> Thanks,
> Ming

FWIW, if the time increases linearly against the number of the LUNs, it
looks typically it's still fast enough for storvsc_suspend().

Thanks,
-- Dexuan
