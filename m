Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21719E149
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2019 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfH0IK6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Aug 2019 04:10:58 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:6216
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731877AbfH0ICP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Aug 2019 04:02:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHJ+A0GqjvOWofsoG1Ll4KAqjQsRu/cpUIyqI+Rl60VwZ0ZpcTXlwb2f8xIbm4Xzibaw2J76a4APTAlODPxehYn/HWExmF6SbW2VdmVjSR28nIVhoo6f6I44iyAOaTbYTbIMeri7sNLrJmrLqLDRcx/rDOXg4fLEwy/Cv2Nm9vE/vVwhzi++k5Ekoi1AYdZi6XC+XOeAPK8ii+zIA7cSJIh21nq1najGNw2W6+fPb5ykPyN4d17ZFZfHyWll/hJNe+fTG8awMFJTaQbN1kQaAsLe3hvlslyXsBNG7Uw23+/lw23t2wcyaMq79L8wArLMT1re1cJqS+TPqJTaihWjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBVHo+/qcyk7/gzycBT8m86pD95QG/Ky3pZnxNcMQxM=;
 b=Ggj4ZCXAu02o6GSU/UZnGg/j88qUYidGC1NafCWyVyfRVQkjlgaIu1x5KY6l356SdktJJFWI87QhwjdAgKyWtkAUCXlo1z+M69TaNuW7ubIzXMyeCFMIDXje12GaDuNHTX86Nzr/UHt1Euq8F7lOUpi5AVf+4u/CgXzDmP8f9VRVi8M+ybarTzRzQD6Ul2g9ujND0kCoI1R22dxkHoqcYrFShlBIknm0v82Iwgwb7wtm/yqYQmyIRv0rlcJnoKSp6xPAooaaSF79t8Glx3AW92QFOX9iXe0J5xkqjQIPKlJlCq+AdJ5wQ0OxDEsiyfViv1Fti546opo+6bYSOF/ybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBVHo+/qcyk7/gzycBT8m86pD95QG/Ky3pZnxNcMQxM=;
 b=YE33pfbQ5kTwouSsikKVXsw4G3AJBHXN4Y5Hnk353EJBd0o+m9+Nwj2nXEgsyWECSG2LmYcpdXkpKM7R7AXixl6LO7UTONryRxmZXRcF7bxNeDnIBM/bc77wAm7/UhOGloICjVJnvnNkX9tMJDG1DTwAeHPam7R+O9vOtpg5Ebk=
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM (52.132.240.17) by
 KL1P15301MB0263.APCP153.PROD.OUTLOOK.COM (52.132.240.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.1; Tue, 27 Aug 2019 08:02:08 +0000
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e]) by KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e%9]) with mapi id 15.20.2241.000; Tue, 27 Aug 2019
 08:02:08 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Topic: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVWBETUUvEuW2UmUKx6Ya3YUCalKcGQnDwgAhoIAA=
Date:   Tue, 27 Aug 2019 08:02:07 +0000
Message-ID: <KL1P15301MB02644C33CA12E8288C4B9AD4BBA00@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
References: <20190821111007.3490-1-weh@microsoft.com>
 <DM5PR21MB01370CB55C3011582F6F8C5CD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01370CB55C3011582F6F8C5CD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-21T23:48:40.2987691Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=61cf0715-0dfe-4344-9bb2-ea23cdedd11a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16efc23d-08d5-49d3-b1db-08d72ac4dbaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KL1P15301MB0263;
x-ms-traffictypediagnostic: KL1P15301MB0263:|KL1P15301MB0263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1P15301MB0263D2B67CA43E97BC584ED4BBA00@KL1P15301MB0263.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(13464003)(256004)(8676002)(6636002)(229853002)(52536014)(486006)(8936002)(476003)(5660300002)(22452003)(2906002)(71190400001)(316002)(4744005)(76176011)(4326008)(107886003)(6246003)(25786009)(71200400001)(9686003)(110136005)(305945005)(55016002)(74316002)(10290500003)(53936002)(7736002)(6436002)(66946007)(3846002)(6116002)(1511001)(7696005)(2201001)(6506007)(53546011)(10090500001)(76116006)(64756008)(66556008)(66476007)(2501003)(478600001)(66446008)(33656002)(8990500004)(446003)(186003)(11346002)(26005)(14454004)(81156014)(99286004)(102836004)(86362001)(81166006)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0263;H:KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lEnybJio6oP08aDT8HP6lkkKdXqA1cIm8YV9P8sD4r/Yeh+yC3CAic0tJEv01cuOUBoALGu0U5QlZ6F4IQgE6XZyKLK90FMG36514qkb/fJXjp4ljDg0B04ATOsMYJ9T+14oBm+9SyrKAx61oFhn+m8Ir9sV9nzIo0aoT052ArMn26tVT+5gwdGUihPwwmcYpCjaLr9VMVPH/LR6e9NUcjpvEKhfgcn4CooC7FoljHFwFO1Yu1eNKvp36Y6brUy+nu5jj8A53MwOiPEZOpoLo6lNuAHwNK8FL7fBwqd1LdPAD9KrSaCSGGGPoYjLUEObZVtogC32gcRG8+SeKRI9DdujDSvhelIZm6hi06bo4XPmNne4dAmXbi20svjYZKoe614RIReUE6UrWVVan7VUyI2lMQB4flXjfZsozaZP54I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16efc23d-08d5-49d3-b1db-08d72ac4dbaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:02:07.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XiuqOUh7UROa6e9NjxCNKSUZuLHegLSyGcOfBNIXb+4aElRap1ERP7XM1N0+kXb7uQGaGmv6NS58a457kbvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0263
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Thursday, August 22, 2019 7:49 AM
> To: Wei Hu <weh@microsoft.com>; b.zolnierkie@samsung.com; linux-
> hyperv@vger.kernel.org; dri-devel@lists.freedesktop.org; linux-
> fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; sashal@kernel.org;
> Stephen Hemminger <sthemmin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>
> Cc: Iouri Tarassov <iourit@microsoft.com>
> > +
> > +struct synthvid_supported_resolution_resp {
> > +	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
> > +	u8 resolution_count;
> > +	u8 default_resolution_index;
> > +	u8 is_standard;
> > +	struct hvd_screen_info
> > +		supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT];
>=20
> Is there extra whitespace on this line?  Just wondering why it doesn't
> line up.
>=20
[Wei Hu]=20
No extra whitespace. It would be over 80 characters if I had put them in on=
e line.
