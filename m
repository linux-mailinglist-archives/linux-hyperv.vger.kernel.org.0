Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B34547D27
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 02:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiFMA4I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Jun 2022 20:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiFMA4H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Jun 2022 20:56:07 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B31CB37
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Jun 2022 17:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfMPyDP84jp/1AtxksZaLcPaTlCmdd0EUkgGi/cUUvLakey3c6LNm/r1pe9QmQLR3NRRlKwpNeD6GGrzt2qhQ+UZuqnNdBWTdhhWNq43AJMOStyg77nIID5UUELWBuCoeLStcwROiGw7q6htfVMbOFspSk66e9a9l7ndioSWJjd7efxeTpbkjt/9+VbXZzYWI3icoWiMEhA+xYEHdyK+D3Uqut2eoqCqFWG3Ubvy/jkx0EhLDPrlJKzZUKqy3LyPGEX3h16wnIMqdDiT6TtZHueEG7UmYehVFxcjinMSMxvJh4eyHburFc/1DA2aKsU2yAKfCuLlSldOSF3ROV/raw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7meGbGM3U1MW86hdP2CRKS7PPmSaxShO4KqAQseONVo=;
 b=EF1L/Ru4eHxDYcexN1KFDQkjyQqnATedlmg1pjS4ZnY2vUszludQOdD2m3GOrEN75StgvbgSDlmF3sI2w1ZDqfq5ZBRBa8twcYtrDSD2TfClka+jqq/lNl5Mf1FWoyvLT9gbpodgDjSzgahq6gqIz0yQvdtJKZ22svrYRotdkmPs0U5IjjqCb504V5SoQlljBZpk2uSHnvHgSW3IWdDjw9DcZWcFsq/KTXU2oClQk1YlPJc8t27fXaB+RQPxejeKxGS8+MYipYBvrxdBrmxO3Ct1y1w+FduTyNBtxM3BdF+Y2B82hugVlbCyfQxE5xU2qdYjPhbBk4y8lavGq36Rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7meGbGM3U1MW86hdP2CRKS7PPmSaxShO4KqAQseONVo=;
 b=cXx8Kha9iCcmOJLhZs1lLLyBc/xkGTXk1lzX7Fj65hLtxO0El1cQdnO6D+gzw0LJE6ai8glPD4MnyQvNCUOrJS0cK6kXbu6gNuuPXxEKZIQKjgz4M3bhE6Z0cVECC2xRpFbfGQ+mC8mljpiiQValiZmDxeC8OxjF9vDWHI5Y90M=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by LV2PR21MB3327.namprd21.prod.outlook.com (2603:10b6:408:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Mon, 13 Jun
 2022 00:56:02 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::5483:4f27:284b:5a5b]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::5483:4f27:284b:5a5b%7]) with mapi id 15.20.5373.006; Mon, 13 Jun 2022
 00:56:02 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-1?Q?Florian_M=FCller?= <max06.net@outlook.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wIAAAvTQgAHnZtA=
Date:   Mon, 13 Jun 2022 00:56:02 +0000
Message-ID: <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
In-Reply-To: <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d435031e-a6d4-459d-a017-b4979a3ee24f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-11T17:21:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73f8221c-804c-425b-4399-08da4cd77d07
x-ms-traffictypediagnostic: LV2PR21MB3327:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <LV2PR21MB33272962ADC6C9EB22E548D3D7AB9@LV2PR21MB3327.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kb/BumOI2O8NiSIjiWBpJ3LRaPNxXGZkG9dR7S0ncKr7ZHmIV0l6R9Kbyn64bgVM4qdYGKanseRKHfN6FumXfJTj8ZFmz2KatfGWEXeASRdpdhNiS2hsAUADwsog9Dae/a4O9AvhHluGxhfnfu0cooDFZLqn/OBLoQ5J+DRBMmn14UPs+vGL1ZdSybeM6vviNiq8IkTVdO3vRZ4vYiJ3jjwzNYrL+sK6g0IAiTZG7GMBSVj/ty8J8GXuFKxgaZKbwcRadc/O8UXZrJCuBvE6jyseIG94D84rcs73AOWvarCr1Dd2yWX9hcCDskMWrwi6NJa0XGL9e2J3ohN/RrlHZr8AxjOsM67wgiI6Rp3bK6dgceN4fLOOm/NiAayMkGd9D/hWOdriDvM9d0MCHtWMq3bt+d+Cct6+6QYHh95skZ1JTdVBX4kwGEDzZxrJd8F/ZqvW3WBYVW3vISQNJJJD8XfJAnc/5dY2jC4FBGDsJz7JkGtng3rGKQsGpLT1OofI5D7S9Qsjysjzkpdmv3kyBvhCrpIGyhTbxynBCjoGIC3rVcwYNtknz4iE3xMRdrV84zHPNx+zeewl9oh9tIUeboF6CyY1Rh6z1gMu63NDwrnyouDOWxCsP7G+gAVaqSFUyJ86hVf3X6jU3mHTkb5YdMNvf4MDP1YntomNeVIyeJ2Rbls8Y/ngZaEC7iPEP9uLb7kpwnmqj8Px5qeKWEh8cXB3taaycC33e+hxuLMToi7YUMYTKaa4+l0u44STxQs+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(83380400001)(10290500003)(66946007)(66556008)(33656002)(2906002)(38100700002)(186003)(5660300002)(66446008)(71200400001)(76116006)(64756008)(66476007)(86362001)(316002)(8676002)(122000001)(7696005)(52536014)(6506007)(38070700005)(110136005)(66574015)(8936002)(82950400001)(26005)(82960400001)(8990500004)(9686003)(55016003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UPnrKrTTczeTFyFAVvzBT75iCUFCudnk4YpsTrfjMKVkCevz/bRe0OEnXa?=
 =?iso-8859-1?Q?aRA6wiA14BqzMVPCCtoxr0PoNWKEIITRsbtVtAcxxMMik6KFh1Ff4wyJ3J?=
 =?iso-8859-1?Q?CjakSSwhw2vif7efEwMDykRaj8or3ngqzn/y383D9whY5VbvK9fhl5V7jp?=
 =?iso-8859-1?Q?zwx0kCyzdzeaUsrzGIOHhuA6ZsQa4j0Uu94VnxnyNW8UEFJw4nonDS5eKh?=
 =?iso-8859-1?Q?QBUB+xChkYZ89p0gbzR3gPPl1ir8bOyIOa3AdaKwTyFXoc0AYOOz7gzGXF?=
 =?iso-8859-1?Q?hckfxMraPvupo1fiiGhX+Ki6v+9p2wf+VRWDscxKCYNzHDJ+m6tUIX/ujK?=
 =?iso-8859-1?Q?SgcLEa11wAyim9U6OMqd2o+wFsVe23KfxOqfhtyXCZMZWm7s9ychoeQcXJ?=
 =?iso-8859-1?Q?mWitGmPQK7m0MOHl6cjpZJLL6EORM/Ac9op7CfwdvIC2KAGHiwQdBImR+j?=
 =?iso-8859-1?Q?5d0AecZvpXONHwpyRGXif2VcqQpFnSaCI4foUQ5a7GBRWzx5Pw45uhpGuf?=
 =?iso-8859-1?Q?y6u/mE7xr0apm7RjiB94Uz8qWPyN0wgMYLwQowzoZ6v/eqeS9tDqIfkid2?=
 =?iso-8859-1?Q?eCJUJr9Z+XUCFRR+G6TiyHs0JOdYzZji/weQu8BgRiDn03dg8xHlbLJQD8?=
 =?iso-8859-1?Q?HwoXNxyHBc0B0KVomYTnGm0ZyQxf1qW9TSQSMOYig+mMK9RAbD5S5LXYlo?=
 =?iso-8859-1?Q?uj8n7P+BAOV6zQzRnlHI5kClXZqgbzPavLVJ2i74nx3+CVss3ULRXh0EQ2?=
 =?iso-8859-1?Q?JCLNxaLbr0r74TnE+oJtBMtF7AuZvHcVXBJmGgH+XViZ4pTRS6sQQQ56l3?=
 =?iso-8859-1?Q?G0C5UO6cvihotoTWVqatwyRBoiDTXWx8PQa3Q9xcRgk1WE+3B2TVIZroEJ?=
 =?iso-8859-1?Q?TK+06TRDNikxzec0cBh9TLVDcC/wvOlzwIfTA82t9x9vJ65l445Wt1/Bm7?=
 =?iso-8859-1?Q?2X5VPjBxCSRTwVB+bXG2vhu5T5kras/KNOfpnnCDWcc1Qxhw3ghsljVDo3?=
 =?iso-8859-1?Q?D1yvYEl9Z/APGjaF6M/YsgD4Zj5IiB5FO+cj8JztgkkXSjRbAti3WKkj4o?=
 =?iso-8859-1?Q?Q+fe/7KJsry3+kFS+kYDnqyNLhF03tqJYRbb2zLLp+43tznF+GP8crUTxo?=
 =?iso-8859-1?Q?CZ21daOhUyKuGwIRzWmSkS4hOBb9YQMGJNswUnlT5x4DuEHYjhZSYOGag8?=
 =?iso-8859-1?Q?uOW/yufGWSLrRUIGPuYAmm51ds/wzKcLYbXDNgQgM5DpJ3xCxkoVUPQ+yq?=
 =?iso-8859-1?Q?80qwE3x+QAX/jPGKnfCCl9O8kcGlv4F7vT2PIocp08qK/7EsELd5H0HmFG?=
 =?iso-8859-1?Q?x/Lax6q14fBXZ79uMFbIcI4H7S+Pnx8NddVfmp+cQR/xrsNDwa0ISNTARg?=
 =?iso-8859-1?Q?6ToBrZyvaRvLV7j/WSFrn+ApeY3BzT1Zne4JBsEGOUIoPgzlWnLJvOnqE3?=
 =?iso-8859-1?Q?Tnlsy5GsReJHRmMeuaTL0gHyN5UGgUsD2rQd+N/fgkec1OKIEV/OjJ+ub3?=
 =?iso-8859-1?Q?9RGKM4dUFT6XDuzZjTr8d5MBkQTiWTqoglUG3Jew0gmm+nQyA7H6FAfIBw?=
 =?iso-8859-1?Q?4XoCINpqJ/eCTqdYlaVgs86R5CnDKwjEyKmcvLei11XZwoSjTRHVC6oHxY?=
 =?iso-8859-1?Q?CVGg5g6VA7+qOTYm4BAS9g1LZkCdHjy557bLRnmpc30fPtQLnVJMjcFnFn?=
 =?iso-8859-1?Q?ksG8qXP6rMn7VeUwpuGOcAMkqPd5gA2VKfPg4djXvFM3CF3qJNMxNsbJmR?=
 =?iso-8859-1?Q?0i1Hl8bsyXTCc91PMSX2F/R12vTfvcqi2DESDLJZIcr74UX2paFAW1K+b8?=
 =?iso-8859-1?Q?+vZ5KtpIx6+mMbepgDmBDrWrNwVSe8o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f8221c-804c-425b-4399-08da4cd77d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 00:56:02.5497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1IqAWfL4ZX2P0Ce4wZ4ZqmGIHXuLQ4Mg47ZO8n0RGBxPQbTwfVHBl5NvwUFVYHH4K9+wrpMytsQmg6mpr3ppNBcwoxnWlgGMN8Qlh43bMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3327
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June 11, 202=
2 12:45 PM
>=20
> > > > >
> > > > > Issues showed up when I set up a Kali Linux Guest. I missed the
> > > > > memory configuration before booting up the instance, so it starte=
d
> > > > > with 1GB of memory, and ballooning active between 512MB and
> > > > > several TB of memory. Hyper-V started to allocate more and more
> > > > > memory to this guest since the reported memory requirements also
> > > > > increased. The guest kernel didn't see any of that allocated memo=
ry, as=20
> > > > > far as I can tell.
> > > >
> > > > Hot-adding new memory is done partially by the hv_balloon driver,
> > > > but it also requires user space action.  The user space action is p=
rovided
> > > > by udev rules.
> > > > In your Ubuntu Server 20.04 guest, there's a file
> > > > /lib/udev/rules.d/40-vm- hotadd.rules.
> > > > This file contains udev rules for hot-adding memory and CPUs.  You
> > > > should be able to copy this file with the udev rules onto your Kali
> > > > system, and then the memory hot-add should work correctly.
> > > >
> > > > I'm not sure why Kali doesn't already have such udev rules.  You
> > > > might grep through all the files in /lib/udev/rules.d and if there
> > > > are any rules for SUBSYSTEM=3D=3Dmemory.
> > > > Sometimes there are rules present, but commented out.
> > > >
> > > Thanks, I'll check these ones out!
> > >
> > > In the meantime, I was able to get it working, by compiling a kernel
> > > with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
> > > Which was previously unset. It's enabled in ubuntu and it seems to
> > > make hv_balloon work properly.
> > > This seems to be the same case with Debian.
> > >
> >
> > Yes, that looks like a good solution.  I didn't remember that there is =
a kernel
> > config option to automatically do the onlining.  With this kernel optio=
n
> > enabled, using a udev rule obviously isn't needed.  The kernel option w=
as
> > added in Linux kernel version 4.7, which might be after the last time I=
 looked
> > at Hyper-V memory hot-add in detail.
> >
> > Michael
> >
>=20
> Awesome!
>=20
> Last question: Since not having the kernel option by default and also not=
 having the
> udev rule in some distributions causes the Hyper-V host to eat up all the=
 memory up to
> the defined limit (and to die eventually), should this be considered as a=
 bug? And if the
> answer is no, how can I (or anyone) forward the requirement to the publis=
hers to be
> solved at the source?
>=20
> Thank you!
>=20

It's unclear whether this should be treated as a bug.  We certainly want th=
e
"right" thing to happen as seamlessly as possible, but there are tradeoffs.=
  Back
when Vitaly Kuznetsov added CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE,
I can see there was some debate about whether this option should be enabled
by default. There was reluctance to do so because of potential backwards
compatibility problems with other environments.  When hot-adding real
physical memory to a bare-metal server, apparently you don't want to=20
automatically online the added memory.

The Ubuntu image you were testing is specifically an image configured for u=
se
in an Azure VM, so it makes sense to have memory automatically onlined by
the kernel.  So I looked at a generic Ubuntu 18.04 system, and it also has
this kernel option set by default.  But as another data point, RHEL/CentOS =
8.4
does *not* have the kernel option set.  So each distro evidently makes thei=
r
own decision about this.  But both generic Ubuntu 18.04 and RHEL/CentOS 8.4
have the udev rules.  The RHEL/CentOS 8.4 udev rule is more sophisticated
in that it does not online the added memory when running on System/390
and PowerPC.

I could envision changing the Linux kernel config rules to automatically se=
t
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE whenever=20
CONFIG_HYPERV_BALLOON is selected.  Alternatively, the Kali Linux folks
could consider adding the appropriate udev rule.  My team at Microsoft
has direct engineering-to-engineer contacts with the most prevalent
distros for production server usage, such as in Azure.  But Kali is not one=
 of
those, so I don't necessarily have a better way to contact them than you
do.

I've included Vitaly on the "To:" line of this email thread in case he has
any further thoughts.

Michael



