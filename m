Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0ADACFBD
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Sep 2019 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfIHQeF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 8 Sep 2019 12:34:05 -0400
Received: from mail-eopbgr1320107.outbound.protection.outlook.com ([40.107.132.107]:47280
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfIHQeE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 8 Sep 2019 12:34:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu8TXRdyDgDG/wMSw/w9Ihp9pUc14JP24qiObzYXH2J0WmfvB/bwxaKg1Iz1WdCUTaMUbt5AnZ3gqtNNN3x+U0ATTU1G+T1/jdiDAK5Qn5P+DPep/Plls4F6Im9QgXUKhy/5E9N/L7e1dOcN8wzCPbSuSFtc3jqTTawT0XUnxfHGEZ5e5jJmuG3ptR65NJaCoXINHVwf9/hAgkM6GoKH8011iflhfnzdQ5pxjZgpYO9UgS5UdA6pKh0eGd4WVSQFk1zgSBFwdnNbUdfMPb4NRRpBzXr0uVl59Ga0KQmodQOphaD6pWcY9MbVjdoUV8OZVNMtF/ha0i/U3+6FTBBclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kBM8Cx6SDbyntR84KAkLtALOo8i/qKSmj/fZSWBMrU=;
 b=FufMJVX0E+GVsKyFSptaQRk685fEFmU3rcyA468jsLmikMql1gZWupL5cN0ibRwESjCyelD2KUx7YnE1oQd1CjtE+C7BGh67gQWUDwxu5hJP6iDIvj2JK5pafYX4oohmQqNGhKzsgKQCo572TjpomomO8a1V5+lxwJXV3unwv70FdlP5YrTh2H1g7VRKpnCAnBVBsSVItItmem1Or7Xe/lxRd+lYscMEl212oJD2rKyOG7Cm3v4eeDBVF4FPrfRW7B5AjR77T75R5L/XrJBE4xZXZ6p9tm8Y9X6TMKgWsk10NDzlr8juvNlIoikhZycPVmhc9NM5K8FaEcbD5uNhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kBM8Cx6SDbyntR84KAkLtALOo8i/qKSmj/fZSWBMrU=;
 b=Hlr0PQNZ+sTOJUuhJ6p/LZQ1/00niKxssnx063PrvC+c9vb9TgjH6W5+qFnXUHeU137kTQp8Kl6OYY2cf6bk7/rcvh/Mn8BYJEH5cA+Xgy1JXNf8VcGHgin8UHxl6R0B2cD8q8ZTcmT/A+FWFoW9g5p8K4AY47DYwxkIKiS8Nyw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0186.APCP153.PROD.OUTLOOK.COM (10.170.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.5; Sun, 8 Sep 2019 16:32:58 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2263.005; Sun, 8 Sep 2019
 16:32:58 +0000
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
Thread-Index: AQHVZO4q3kr8cCc730q424LopDWEJqcfGZvggAKaLoCAAER9MA==
Date:   Sun, 8 Sep 2019 16:32:57 +0000
Message-ID: <PU1P153MB0169F450E1A5FA5784C062A4BFB40@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
 <20190906200325.GD1528@sasha-vm>
 <PU1P153MB01697512A097B489E0440E13BFBA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190908121329.GD2012@sasha-vm>
In-Reply-To: <20190908121329.GD2012@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-08T16:32:55.0204484Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c79d20c-3124-4a20-8bee-ab30a052af9d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:41ee:1740:6ac:c2cd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a7cb96-8d43-48c4-b74d-08d7347a3560
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0186;
x-ms-traffictypediagnostic: PU1P153MB0186:|PU1P153MB0186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0186909B88FF11E2719F4E61BFB40@PU1P153MB0186.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0154C61618
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(61514002)(10290500003)(53936002)(66556008)(66476007)(66446008)(14454004)(66946007)(478600001)(186003)(2906002)(486006)(11346002)(446003)(46003)(14444005)(256004)(64756008)(33656002)(476003)(5660300002)(6116002)(102836004)(99286004)(76116006)(71200400001)(71190400001)(6506007)(52536014)(86362001)(6436002)(4326008)(9686003)(22452003)(54906003)(25786009)(316002)(7736002)(81166006)(10090500001)(81156014)(6246003)(6916009)(76176011)(7696005)(8990500004)(8936002)(229853002)(55016002)(305945005)(8676002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0186;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qi/yDaaRfGNhahXjN+/hGwmwTnpMskZ9CI6/RC1ow3nlnZG+ma2o9IrgLNBFw1CWMdKHTv4NY8++l49z9LDK80GErmUWxqWNfLnqfBmDyyAiMstnPzVAyXwEe+5ZSbNr8ZFSVtGj8GDnRCHVrz9etVa89eMkm8f5Cg8SVLN/l3PoivcANmYi40NWq/gQb9MuBu88OVhOs2IfmVcwVfwaBU7n+nIJJIFkX7MlMRBzC9VxIXgqT/VRpFmSGz+IBYna9s2G+w9X3GlJXq0Lv9AFitNzOsVpUuYSj8/jsT4znUnPaRxhFGhGLeaFT61tpF/2+D/7Hoi1iA+lqYiVWfCgdAFwyD5pWxmcHADzez8utEPyJWejCoO2I71/WK1mhxiXpwIjLU8CgVyqpScNtyWYJdeJWimZEPUksymARBLhNAw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7cb96-8d43-48c4-b74d-08d7347a3560
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2019 16:32:57.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkQtOI/Cq9ITWJ4DGSo/yaYPfnwrpbD8QUStnlUTeb3vfXxk3+Z/GYqiO8lGmNlmS14RoGChkMqY/54/wBlFhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0186
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Sunday, September 8, 2019 5:13 AM
> On Fri, Sep 06, 2019 at 10:45:31PM +0000, Dexuan Cui wrote:
> >> From: Sasha Levin <sashal@kernel.org>
> >> Sent: Friday, September 6, 2019 1:03 PM
> >> On Thu, Sep 05, 2019 at 11:01:14PM +0000, Dexuan Cui wrote:
> >> >This patchset (consisting of 9 patches) was part of the v4 patchset
> (consisting
> >> >of 12 patches):
> >> >
> >> >The other 3 patches in v4 are posted in another patchset, which will =
go
> >> >through the tip.git tree.
> >> >
> >> >All the 9 patches here are now rebased to the hyperv tree's hyperv-ne=
xt
> >> branch, and all the 9 patches have Michael Kelley's Signed-off-by's.
> >> >
> >> >Please review.
> >>
> >> Given that these two series depend on each other, I'd much prefer for
> >> them to go through one tree.
> >
> >Hi Sasha,
> >Yeah, that would be ideal. The problem here is: the other patchset confl=
icts
> >with the existing patches in the tip.git tree's timers/core branch, so I=
MO
> >the 3 patches have to go through the tip tree:
> >
> >[PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
> hibernation
> >[PATCH v5 2/3] x86/hyper-v: Implement hv_is_hibernation_supported()
> >[PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V clocksource f=
or
> hibernation
> >
> >> But, I may be wrong, and I'm going to see if a scenario such as this
> >> make sense. I've queued this one to the hyperv-next, but I'll wait for
> >> the x86 folks to send their pull request to Linus first before I do it
> >> for these patches.
> >
> >Actually IMHO you don't need to wait, because there is not a build
> >dependency, so either patchset can go into the Linus's tree first.
>=20
> It'll build, sure. But did anyone actually test one without the other?

Nobody tested this.

The fact is: even if we have the 2 patchsets, hibernation still can not wor=
k
for Linux VM on Hyper-V, because we also need the high level driver
changes to hv_netvsc, hv_storvsc, etc. I'm going to send out these
patches soon.

> What happens if Thomas doesn't send his batch at all during the merge
> window?
> Sasha

We need all the patches together to make hibernation work.
I just meant that the 2 patchsets don't have to go into Linus's tree in
a special order, as there is no build issue.=20

Thanks,
-- Dexuan
