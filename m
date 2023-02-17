Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC20B69A3F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 03:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBQCe1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Feb 2023 21:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjBQCe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Feb 2023 21:34:26 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020014.outbound.protection.outlook.com [52.101.56.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669774BE88;
        Thu, 16 Feb 2023 18:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oglBezXRXswFSdFBBWXv8+kKBirUF/Kgjz51nrQSwqKUP9zWeXlkryNkqgYeK8LKsjUbYin4Mnr5vq3ICH/VjoHjEITxRuzONszB4o8kY2rWW3X9JMx3fm8lTxysSbZd+vBeHJF6wwohYEXoHDCbi+tBiSY0X8TztvmPJ70WsAzTvqdydCbwgNIfD+BD7AyHX3hHT1aULsyN6dB6ztezPEi9xjnTvg/0x9COtZlZUBxUNHOfO5Gn5MbS4T1VW9KRxEzJC0fLDMwIlvflijSvo0geaxUydnOlUNHOL2TTIPpHMowWbCjsKSMTA2CQBMQVoX4rr69SwMa9ZXVqFynThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBa6JhBN+OMo61IKaHmR19bierqXhZiF/FBHt39wVx8=;
 b=VjHMMCTqinixulOY1VY1AvSlNs+7SkxHbPlKGC+sqy+6zid3HjIQ1J008PugLsVbkQWmw04rBnbZmi3fWVPD7cZ11Dz3x1x4srOJ1tvnqOuXCMiGTuKcjbFgmaicHweBUBkdEShdWh0fIjIkUMH+NZyrhcrhLI6LXb2ixsKT9ThDITbaQ2KstLZ9sdmAO1KXCHJXuCh2W82UDd58lpxAErARMuykgBcb6GLyROISdrQ6GqWhZwSHNqCixsCTmvMjrJ9/f69ritNQHo/Ju9N7JBOTe354z2ymn7EfVDtO5g4tc37JYnZ+jy1Lf4mWFjC1GkbH1EWjTo6g2JbcSXnEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBa6JhBN+OMo61IKaHmR19bierqXhZiF/FBHt39wVx8=;
 b=QC62BmA7ZEDDsXMlY2hr9LRIge37U29/MlWY4so2u9UP1pAwgsz5apfgNM1bNmtd4Ixld1AIRC77OFloso/x6HScKuklJaUo39COs0qAM9PlaKYKQ2XX3M5A/z5MPyhnyrRCnCwURDI3z9DaLrFvkLPBc93R2GBdSUK1pEyyoSM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3490.namprd21.prod.outlook.com (2603:10b6:8:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.11; Fri, 17 Feb
 2023 02:34:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%7]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 02:34:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Thread-Topic: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Thread-Index: AQHZOmyDXwNyD+qOhEijfVFgcoX9l67OqFMggANgBoCAAG3icA==
Date:   Fri, 17 Feb 2023 02:34:21 +0000
Message-ID: <BYAPR21MB1688A3CB5CD51A6A6921D926D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB16881C783D58F2F20B7E196DD7A29@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230216194101.GA685@skinsburskii.localdomain>
In-Reply-To: <20230216194101.GA685@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=551607db-8d45-426b-b3a3-409333ce1a11;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T02:14:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3490:EE_
x-ms-office365-filtering-correlation-id: 45247b0e-ffc0-4fb1-423d-08db108f79c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Trltf30mxXqS++nEBqcpq8dTTVGWj+UdEyQPsZiqv0m23L60b0d1XUJ8dmBJWep7O7vz/W4ajMs3nnrKx6w7sqinIg/zv2YTR3Si9C//UJA8djKz5JIAFDIAw2OqoG9tI45yqpZkSpDcjQ7o6vZAR9RGpfczK1xhiN5H9OojD0gPUJoPD1rQtzlnOLDDLcg1aFmDxB1hNG4eSbde+7+TZI56xosmGYElvYHMSJ2WxfLIuWMlEf2f2klFDGM5VOZo0MFA4LxNPj4gabzNKYwhPFZfcvttvKvH6v6lm/a+uxkVK3fl2oGu4lbIFBfUvd20RtE8pHZotYfteZ2wxje9x4LYOoyKTdkEsj195Kew88uvLLli5zaJuWB9r1XwKwnZLqfMOvyp/D8HKpHI47PjYgp2pDNyDiJSvW4vKfkq3pTfeYfEZtueo/S09cQS+Y7kTSpsKvqdkWDvpcBTQVZJohc/BTcZMXHp2s6GzxB8+mdvqaq7cIrsu56fHsRjtTdjauGaAjzHxURzbP8Hv+PkkHXiQ0CYFwoyAPh15D3rS0Xygss5vRYlGhqzhtC3YwvtH8W8NDAHoCVkNwvoPydZbw/zzPruzh9RjmGsDfCql1NocfOvUqGkA/pwluC/J4sLCy7wcPJJeeoZQzgkT5iXuX/BceQw1VM1iBEsLM0r4obCJZDfI8Cuxzv8JhDmUSfOoEnQTLyY0y1O+MP5DcV5hqs0wqbOS9pwE7h5Y1pwXQ999WXvLEvnnPY4XJ2+eR6N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199018)(52536014)(82950400001)(86362001)(54906003)(41300700001)(2906002)(10290500003)(33656002)(4326008)(38070700005)(66946007)(66476007)(66556008)(66446008)(83380400001)(64756008)(8676002)(316002)(478600001)(76116006)(7696005)(55016003)(71200400001)(186003)(9686003)(122000001)(5660300002)(38100700002)(6506007)(7416002)(8990500004)(6862004)(8936002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwYQqJNUFi2CdPEOWQR0ST13vqDLd8kbTfC3VvWfVFUYjg6bvuRsCa+PgJF3?=
 =?us-ascii?Q?b3YyW+A/TlgmrjYVfsikwr3DSGlEczMPPn3xNFzlPFBv40k34UmpJb2Gti9/?=
 =?us-ascii?Q?3KJzrSYTGt0AMVQzKBxeR5NC5/TMQozLWUOM6FIub/3c4F+eeQe+SxFF6tIj?=
 =?us-ascii?Q?DeO9Y6pkH7JpPLCjKNRKUgs61H2yO3A3GzMjhXw0ZfMft7bagRnEssIkEy/j?=
 =?us-ascii?Q?yplJ4eWbH2TNScg2EMnVE/2wp9Am2ptjNuNjvOw5UJZ0sBacAJnwyZdwfuXv?=
 =?us-ascii?Q?X0QfZd/P7Knp7q4LVjMj1JQNDSY/8kXI6iZcbmhI0Svx1jJXX0TjOCP+/OtY?=
 =?us-ascii?Q?Lururi1//Ta02XAHLkhGkFIZZEIJm7hLKz3u/b0whUWHiEK6XiFPMjPGomrE?=
 =?us-ascii?Q?IxVnCT3MMf1pESpLPgX+bgqKCvGOzzexkegihx1DUicclrE9dVGEjJS356BN?=
 =?us-ascii?Q?Hl0O2AseRJZWRm4GIldbbKDwVxYE2ttYQ0jZkvSwqCeqgBIA+fBaHueZUFEa?=
 =?us-ascii?Q?FCcG6qf5cJGoIWVwHcG+HJl8tQL5cPMgIm0iLt2/37Rf5blqLb9tmhgQ6R/b?=
 =?us-ascii?Q?SBKWThpEb8euYO+j5wu+yJYTGuu+G1xyOhQTHO8jM+KpTCAFGeXzXSD6gaXi?=
 =?us-ascii?Q?4mm2dSp/jbXyiGy/h1J6wQHsD4/5RhU61MYzrmCHtsbtFu+OKG8TuufHFBMn?=
 =?us-ascii?Q?qtZBl3J8nXefybeDMXZunZP+DujVx78t8QQ5J6dpYbh3xtfzryIBZMBlCILV?=
 =?us-ascii?Q?y48qHTsPAM8jIqgwiVH/ENUULKftQKMmgJ6B2EZR+Zy0j5WNbkqycMNxr9K9?=
 =?us-ascii?Q?QnhDLnBvek/Ck5u7u5vKRrJkDwda3Bds7Xi+Ss69xPwrzr0re+ni7IGBbvmq?=
 =?us-ascii?Q?JTTpjBxDqRpJ8syQKmyMNu3j+1hBxcsDpfwDBLegMbOIYijONkUO0QxyNkw7?=
 =?us-ascii?Q?vYHeiSarMrcpdqmzvp2bk3SEsNMl7ANrzuTWbn77oiTlfhFljLB4F9L5mlp0?=
 =?us-ascii?Q?bJGvLDyhjo6oevNLUbuXLBPE2gT1pLRllGioMUOPoqPY0LZL4HDGXGBxlCFs?=
 =?us-ascii?Q?IqzbCL1oiGFuISIBCUR33jVVZ5O3UChkBQYb+sDhK/XLaJQbwc0hA0uVgZSZ?=
 =?us-ascii?Q?i4/XmxV+QIOXDpctnTa0qElKM/QrhNN8r96+li0CiT1gMNUOVkpfxrwSdZGs?=
 =?us-ascii?Q?QkyStOXbz47qSC0ABIUKWrx7ES6Vprdh1V0U483+NviIELXWT6FXwaeW0hPH?=
 =?us-ascii?Q?MtywRq3f5Bs8IxrPm7VCPO2nlOrODUiDX/VV0NyBLgEaqthRpgbrnHndeyMT?=
 =?us-ascii?Q?hJtmWnK2xVsaZqLnVabajGgtGm5kfvUxY1Rd7tYt2i0bySq5w9muoYjitVtt?=
 =?us-ascii?Q?lXOayVWRLfEp2e9yN8665hDCiTfWcdUKJ6LxBAwlu5l2LtZmTidPLrildV2F?=
 =?us-ascii?Q?JEOcv0+FqOs3EJO1XALjqETHaylTlEwryJxkXLV1ukWyDuEefp4e3okgeR40?=
 =?us-ascii?Q?hQ+giugPsFFz59IE1ve94HL7RjbU2otNu4g+RXphoXuJteaw/pFqUBbwGD+d?=
 =?us-ascii?Q?vGMCT4amuK8StEfpNZZ+HEEpjWL9/XYPlEDKMGH7xbZHhipR2gZ0c84+NvDs?=
 =?us-ascii?Q?EKM52yBPhO81vw/27kba+IMezimBwzNzWr6qYH2cww4RH1q8P6q9culZhvhX?=
 =?us-ascii?Q?/Dyq3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45247b0e-ffc0-4fb1-423d-08db108f79c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 02:34:21.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9PIB43LttoczAh34nZQqWfDDvOn9XT912CtU80KwTcSeY9ksj1Yl/kkkeeE1Em25AxhOkWvPhLMOFC5lZUljOCKcVV6Tn7f0Ysd4hHq8W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, February 16, 2023 11:41 AM
>=20
> On Tue, Feb 14, 2023 at 04:19:13PM +0000, Michael Kelley (LINUX) wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > >
> > > And have it preset.
> > > This change allows to significantly reduce time to bring up guest SMP
> > > configuration as well as make sure the guest won't get inaccurate
> > > calibration results due to "noisy neighbour" situation.
> > >
> > > Below are the numbers for 16 VCPU guest before the patch (~1300 msec)
> > >
> > > [    0.562938] x86: Booting SMP configuration:
> > > ...
> > > [    1.859447] smp: Brought up 1 node, 16 CPUs
> > >
> > > and after the patch (~130 msec):
> > >
> > > [    0.445079] x86: Booting SMP configuration:
> > > ...
> > > [    0.575035] smp: Brought up 1 node, 16 CPUs
> > >
> > > This change is inspired by commit 0293615f3fb9 ("x86: KVM guest: use
> > > paravirt function to calculate cpu khz").
> >
> > This patch has been nagging at me a bit, and I finally did some further
> > checking.   Looking at Linux guests on local Hyper-V and in Azure, I se=
e
> > a dmesg output line like this during boot:
> >
> > Calibrating delay loop (skipped), value calculated using timer frequenc=
y.. 5187.81
> BogoMIPS (lpj=3D2593905)
> >
> > We're already skipping the delay loop calculation because lpj_fine
> > is set in tsc_init(), using the results of get_loops_per_jiffy().  The
> > latter does exactly the same calculation as hv_preset_lpj() in
> > this patch.
> >
> > Is this patch arising from an environment where tsc_init() is
> > skipped for some reason?  Just trying to make sure we fully
> > when this patch is applicable, and when not.
> >
>=20
> The problem here is a bit different: "lpj_fine" is considered only for
> the boot CPU (from init/calibrate.c):
>=20
>         } else if ((!printed) && lpj_fine) {
>                 lpj =3D lpj_fine;
>                 pr_info("Calibrating delay loop (skipped), "
>                         "value calculated using timer frequency.. ");
>=20
> while all the secondary ones use the timer to calibrate.
>=20
> With this change lpj_preset will be used for all cores (from
> init/calbrate.c):
>=20
>         } else if (preset_lpj) {
>                 lpj =3D preset_lpj;
>                 if (!printed)
>                         pr_info("Calibrating delay loop (skipped) "
>                                 "preset value.. ");
>=20
> This lofic with lpj_fine comes from commit 3da757daf86e ("x86: use
> cpu_khz for loops_per_jiffy calculation"), where the commit messages
> states the following:
>=20
>     We do this only for the boot processor because the AP's can have
>     different base frequencies or the BIOS might boot a AP at a different
>     frequency.
>=20
> Hope this helps.
>=20

Indeed, you are right about lpj_fine being applied only to the boot
CPU.  So I've looked a little closer because I don't see the 1300
milliseconds you see for a 16 vCPU guest.

I've been experimenting with a 32 vCPU guest, and without your
patch, it takes only 26 milliseconds to get all 32 vCPUs started.  I
think the trick is in the call to calibrate_delay_is_known().  This
function copies the lpj value from a CPU in the same NUMA node
that has already been calibrated, assuming that constant_tsc is
set, which is the case in my test VM.  So the boot CPU sets lpj
based on lpj_fine, and all other CPUs effectively copy the value
from the boot CPU without doing calibration.

I also experimented with multiple NUMA nodes.  In that case, it
does take a longer.  Dividing the 32 vCPUs into 4 NUMA nodes,
it takes about 210 miliseconds to boot all 32 vCPUs.  Presumably the
extra time is due to timer-based calibration being done once for each
NUMA node, plus probably some misc NUMA accounting overhead.
With preset_lpj set, that 210 milliseconds drops to 32 milliseconds,
which is more like the case with only 1 NUMA nodes, so there's some
modest benefit with multiple NUMA nodes.

Could you check if constant_tsc is set in your test environment?  It
really should be set in a Hyper-V VM.

Michael
