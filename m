Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C350FAC2AA
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2019 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbfIFWp4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 18:45:56 -0400
Received: from mail-eopbgr1310113.outbound.protection.outlook.com ([40.107.131.113]:8560
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405017AbfIFWp4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 18:45:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXdiO6KE71LrNhwaax+bDPEfg02J757Pwioxm9sOCBrQpTYrp7pQi/t4Ua215sWtNQmqA058YjmEnO7c0CpR6ALalrH+iITbUJeJuw/NfTQR/C8xUDChZJeroIC1GlCW3DNVCemD+GjbMHuky2WSnrxJ/YC3yE9MjXqYEmHsKqPDkxT2Tq9C0M5Oz1GW5KvLxA8smWbl6NVBjbKBuiKIdXN43EOiyn12duIl5CICtjsHbWRgsqrny2LGIA1OAlLTRCRtvgYTJqthcUPwUEnmQewnCYLtrdJIvrvWSEFQYnkgF9+aQnx8Qu127IBU1B2LYd79ax5qHS3QVHpFkC9QJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VOfhLMEwc0nEH2aJAM/nO+8GviGtXlqHMBCiFlL1Q4=;
 b=mHRLOzhcb0d9Gbsf8ZXPKpzW/mo8oF3yNMB6stpURDdLdVDVNGzmSQZcZV8ZFBc3OrOlWfXiKbj5AF6SWkPOakac/kWARrJPxLXKPnNCZwyAeoka4umXTrUt2ryWrZizfm3gqihh45YZ7syHrtuUKCn87eikQi/pU9EWY//yPPvfdlWdk0JROsFgvo1F2oIfCpqPcoS26fdolBvFE/R+0cECPcD0Qz7lSbF0Qs3F8QDsPdcXFUkYc4zjq1ioAJpG5btsZXw9v3oGMVrHiUr+lVF6bujuhgoC79An31DjbBxt5eFLKWZtv9j91jNmCVZ36+8veFoA/Fl4WPFt763m5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VOfhLMEwc0nEH2aJAM/nO+8GviGtXlqHMBCiFlL1Q4=;
 b=ljyDan3uquWjv7RTkBe0azq2hRibLm2kgS9KuaL1xcbfuJcFkdBaeHpapb10cQxS4nNJaJTOkIoLcglySWFXdJdN1JQsEXOvxRB55BsW4gtBzsnRRWPu1YDApqoEp32L/GgvKJ8NMylOVVcltzBe4pP8m8NIjBgm6x0x0AdG9Ko=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0203.APCP153.PROD.OUTLOOK.COM (52.133.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Fri, 6 Sep 2019 22:45:31 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2263.005; Fri, 6 Sep 2019
 22:45:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/9] Enhance the hv_vmbus driver to support hibernation
Thread-Topic: [PATCH v5 0/9] Enhance the hv_vmbus driver to support
 hibernation
Thread-Index: AQHVZO4q3kr8cCc730q424LopDWEJqcfGZvg
Date:   Fri, 6 Sep 2019 22:45:31 +0000
Message-ID: <PU1P153MB01697512A097B489E0440E13BFBA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
 <20190906200325.GD1528@sasha-vm>
In-Reply-To: <20190906200325.GD1528@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-06T22:45:29.0874008Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=02fde12d-e263-4d00-b3b2-d0d411bc1267;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:310e:b8a5:374f:67ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e431e7-c086-45f0-081c-08d7331bec3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0203;
x-ms-traffictypediagnostic: PU1P153MB0203:|PU1P153MB0203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0203CE8B1B4A7684BB13105BBFBA0@PU1P153MB0203.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(61514002)(199004)(189003)(71190400001)(55016002)(476003)(76176011)(22452003)(54906003)(6246003)(99286004)(10090500001)(6436002)(8936002)(6916009)(7696005)(81166006)(81156014)(9686003)(8676002)(71200400001)(33656002)(14454004)(2906002)(256004)(53936002)(14444005)(4326008)(478600001)(25786009)(6116002)(486006)(6506007)(86362001)(8990500004)(7736002)(305945005)(52536014)(46003)(74316002)(10290500003)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(229853002)(316002)(5660300002)(446003)(186003)(11346002)(102836004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0203;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YBuErGLUIztwNtm3vIZDRN6D/DJS1TOOLCDLRN8/887rjF9e2WnOsk8342T7kfQucYe236eBxVNprZVj+FG4sfmny8SvqHc2Kgww9/pI5oIFYe9X2MNHn70rKyQ1IrXitpl15P6oB03NZi9fHeeFR/cYI5lFqc55NfQ3FLaQLun6deUP7AsAl9Cvg8nVpXyk20z0j21KzzmdVsyhtLdnAWgyR887rn85YVRlju96rkWnbhugYZPJtdJxpPrLjE2zTItkTE1oRwngfPIy/yOqJNJ53JtnkPQ4RBNYwU65nOT0Ee1Yf8PoqM5wqWns30ouLahJdL6QPvfsZlSXY9JxDGgZR1TgkfnehU7IRneyp7BCHEhJgE0nXV1s11dxyvNJfREOhz/+M2LLGzopiLc14Ont8nFRuxT9Af9p7yX5M5w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e431e7-c086-45f0-081c-08d7331bec3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 22:45:31.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vj/Fv0Us/gjYvDeL1lK0FTS/1vn3Y1seRpukBWsFDdfN30QvNkXFwAub6uk67hMiA9jFAqwkco56gSVMocqJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Friday, September 6, 2019 1:03 PM
> On Thu, Sep 05, 2019 at 11:01:14PM +0000, Dexuan Cui wrote:
> >This patchset (consisting of 9 patches) was part of the v4 patchset (con=
sisting
> >of 12 patches):
> >
> >The other 3 patches in v4 are posted in another patchset, which will go
> >through the tip.git tree.
> >
> >All the 9 patches here are now rebased to the hyperv tree's hyperv-next
> branch, and all the 9 patches have Michael Kelley's Signed-off-by's.
> >
> >Please review.
>=20
> Given that these two series depend on each other, I'd much prefer for
> them to go through one tree.

Hi Sasha,
Yeah, that would be ideal. The problem here is: the other patchset conflict=
s
with the existing patches in the tip.git tree's timers/core branch, so IMO=
=20
the 3 patches have to go through the tip tree:

[PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernati=
on
[PATCH v5 2/3] x86/hyper-v: Implement hv_is_hibernation_supported()
[PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V clocksource for =
hibernation

> But, I may be wrong, and I'm going to see if a scenario such as this
> make sense. I've queued this one to the hyperv-next, but I'll wait for
> the x86 folks to send their pull request to Linus first before I do it
> for these patches.

Actually IMHO you don't need to wait, because there is not a build
dependency, so either patchset can go into the Linus's tree first.

The 2 patchsets are just the first step to make hibernation work for Linux =
VM
running on Hyper-V. Next I'm going to post some high-level VSC patches for
hv_balloon, hv_utils, hv_netvsc, hid_hyperv, hv_storvsc, hyperv_keyboard,=20
hyperv_fb,etc. All of these should go through the hyperv tree, since they'r=
e
pure hyper-v changes, and they depend on this 9-patch patchset. I'll make
a note in every patch so the subsystem maintainers will be aware and ack it=
.

Among the VSC patches, the hv_balloon patch does depend on the 2nd patch:
    [PATCH v5 2/3] x86/hyper-v: Implement hv_is_hibernation_supported().
I think I'll wait for the aforementioned 2 patchsets to be in first, before=
 posting
the hv_balloon patch.

> Usually cases such as these are the exception, but for Hyper-V it seems
> to be the norm, so I'm curious to see how this will unfold.
>=20
> Thanks,
> Sasha

Thanks for taking care all the patches!

Thanks,
-- Dexuan
