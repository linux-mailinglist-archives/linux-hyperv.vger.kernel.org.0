Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7ED78B2EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjH1OWo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjH1OWW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 10:22:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE9F7;
        Mon, 28 Aug 2023 07:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuKNaYH1HOscNhkZnE68rc2UnfFR2RUSDJRUpKTfL4NWPK1ZOELCcIFXBf0N6qU4VOUJpu6IxVz00iJUZ26AplAXE+S+znQPb/x0lO/msy15nUCw9sCrSfvvaC5lC+kQbeabKoamiMb77UVW/gEvNnW4M0s+oKCs6N2ODwF3vGk8LzN9c2qZrKa0BRzYPvV2mej9Bj6WEtN+xydwFtAUJ1zU8JiuyZtTx9AoN0pd8n3pA+Pw2RxlgOoVdDmvsyodvjml9+xc59gzfEIHjtKQKY2hFsBooMI9ECJS5Hcpjf8G+0pKgUnj8C1YFTwu4HWKM5egEyY+mSV5zc3C/LArAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWEjXsPXkvvh1iRePzBsm4icXiZ2ZiafZQcUqoRMu7g=;
 b=c/H7lJeFuvCzqHe8+4/CKtKYXPgvmwujwO+kCdiUxxiNppjY5epSc1XLsl1pGo4tBqoRESo5Fw3acJU73tsesZrPpaLaQiBEN0mar1Kn4uIMYmWtoDXnRWa5HMn5M9qMRexSdj0oQ/IdfLv9vDhiMFTkOIIn9QhovfMx2y/2uDOw8bdKEuY3tl+ssTKY/MQm8yvnGHuPiYKaTkhfyH4zZmwPXuK3COGlL5o4zLMVPTvyULTMONhnq/rEg/2jXNt/DBKs5Dd75VpxzgT4QUbEPChIoYn9krLb1iGvZXYgiE/GTFZiI61Uaodb21bNtoceFNhq7Xu/YodLI51RQd4mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWEjXsPXkvvh1iRePzBsm4icXiZ2ZiafZQcUqoRMu7g=;
 b=Z/YR7fQUYf0aga9Dz5lJgfdqz1vo2QReXXW7Lmw8B7lY6aNdQKA4keQzatCBM0LgTgawJvj/2ZXWs0QroLUKdvH3g25yjz0xcp+oMEjydZK/h8TwjBEXYZ0FCMXX29xjCP7/zoNprNYMtz0IbvSemOrkwOXfY48ooHcAfWKcVJM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3737.namprd21.prod.outlook.com (2603:10b6:208:3e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.4; Mon, 28 Aug
 2023 14:22:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%5]) with mapi id 15.20.6768.007; Mon, 28 Aug 2023
 14:22:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nq/eB+iAgA5qfICAEu+xIA==
Date:   Mon, 28 Aug 2023 14:22:11 +0000
Message-ID: <BYAPR21MB16884D7E004A4544F3EA6314D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
 <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec984448-4b40-4599-8738-7909b838a118;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T02:28:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3737:EE_
x-ms-office365-filtering-correlation-id: ff29e608-746b-4607-c122-08dba7d22b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmdBo5jtsCY++t4Wxw1FEO62Z1hBaRrAGpuy3iWBCBzs4dNEVqqtk23nY3UzTb1xl1tAXo2vtDRcjy9btHDkzX3TF2x2ppXaYGI3hxvxZdDoNwzWBqVpu4AwDLj1tAZfJmquYIgqRIpy8Xg8Fo7jDYfi+Ng0LLFNrOHT7G/3CVG6v3FGsJDGNgZKOPK53Ku+R8EvaKS0xMUvrTV0jA//B139oPbG/U5kRwM0IWEdxK97xeqCd+pi4yJmi0LNE5KuaWkqObVHrhqtM0emc1q/zueQcx32ltvAPa/rWh37HTXctX5Vlw916OT1eNg0aYO2hcnibaFI20XGCW0xEx0xmQmGDvq5pMgm/w1R9re4ULD5v/OTCgvjixn852GB3ITI/1ixAYB9Tt6cR/J5tytJ96r+BSSpa3u6Hi0zYkyhNl/tGuo3LAyEPbDlON8G9itDUWZGNnJh8FQutDlPeO63M7t7mlfMGwzKljOWF6dX4pb9qzbLACOBL4ScY0pU3d22vpd9Mjl7bBJgx/SqLnXHv/F8I4AB3RAyXEDrw8ONj4u20J4PV4L6x2BfuQkK37/o0HbEm8KoCX/2uosKs30tVWlagd+vAJBLvArPbaKkugC4RhLhCf0d/kI/hhAr30qWeKXbKVC5satQV9Vl7z4UUuC/7cIdS+T+fT0faJlMqe0ZYx4x7xbukq0PwyCa8xKK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199024)(1800799009)(186009)(966005)(9686003)(7416002)(30864003)(2906002)(12101799020)(478600001)(10290500003)(66446008)(54906003)(66556008)(64756008)(66476007)(7696005)(6506007)(76116006)(83380400001)(4326008)(26005)(5660300002)(8936002)(8676002)(52536014)(38070700005)(38100700002)(82950400001)(66946007)(316002)(71200400001)(41300700001)(8990500004)(82960400001)(122000001)(110136005)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Vyh3egTTfOJVxuEJCRKMlqMsBC+XfzylMBPsZdEt1P8M5ZuIbYYSELk6m+a?=
 =?us-ascii?Q?kjBm/LEOvaHH8/hgwWCUAJT93sKu9amYFnLt4kyNMZrWyXYC1IrhNEI4IbBs?=
 =?us-ascii?Q?GD6wcyVFMFFpI9R6HhAaf3J/C962zDAtDiu8efsJgNOeGoyzYAEYYoOCjSAG?=
 =?us-ascii?Q?ERgCvJAa8uoKIsamBunV1QILppkBh0roOjDboq+O8ThIyEV074iSD+RtvsUp?=
 =?us-ascii?Q?YWQso3hoE0WZfzeX1AaAMCjuA1DZQ0mUTpwRv4055buuonY3TNlJwTw2DfYc?=
 =?us-ascii?Q?FrJecpenv7Zj71AVv/lmBadfjpq18WHf0xR8PzIzNDzqY9iDdl6ymoqDpYSa?=
 =?us-ascii?Q?Nivq8aqdxE/WhGTVqyoS4ShMagP2SuKEIzF2dE4reJ6ypnz2TUbJSYAMFL9r?=
 =?us-ascii?Q?YXJWu9jHC9uCb0Ms++iqtJ09BXfjJQAob8wxdwDRFQo58hdgL83gvxsZq8OA?=
 =?us-ascii?Q?SHMHPoh+5OTZ4E+JZTK8PJjqPnxZs2MAaeF369VZ4H0G9NFwnUJ1U3CIVXve?=
 =?us-ascii?Q?mgEaq5OouBQowhO7ORjBK9rzDDuHVzMRohiGCK3epYuprFT5HmYztlBovrqd?=
 =?us-ascii?Q?CCfiai57NHoNuxlxyYpVuPOhEvcbbEivYChvjfh2xkv7FScdBX/9BalJyEKR?=
 =?us-ascii?Q?lTDhLUNtGzz2NuzFwXtPBeTMijiom6f2btvC/GD2QMyC/dyrmyfEcztsNpNk?=
 =?us-ascii?Q?1Oqk5EOZTcK8uB+yqaAEDVtakO9OOefSV//wxX0v0DnIkSKaNfXC3r40S/ds?=
 =?us-ascii?Q?jnOfT4tJMOmGdFNWU8k68/aSG5g7Gn9ga1UXl5iLLl53CV82xNX2WXLW2wj5?=
 =?us-ascii?Q?mggMAHv0nXUjC6aBArvkNmyMjx8iQELul78l/0GlAunXwt5IfpgZjwIyKfVl?=
 =?us-ascii?Q?I+k+811DcQbJBVAizcQp8Z3BLtV+KQh16p7MTGs7MsTY3B0N9fw/r7HpYqg2?=
 =?us-ascii?Q?jNya5skrCXGXnoZ/7TfAZOg6Ahvoud6obfmlaK9I1o8iySi4NewCKqdshaWY?=
 =?us-ascii?Q?ZY7slRxoAkfcRzOm+TCG5r0vua3x/V1ZBPdBX92hgFHfyaL2jufOwhxYY7gt?=
 =?us-ascii?Q?hUrW95LVCKZKLmgAbGPQ/QGK42jWasHFiegtzxh7vxfq3Lg6Le8TetZZO54C?=
 =?us-ascii?Q?kO35ayY0SMdfrlrXFRI/IERvMPh3+ohkHcEtgdspjIAWcte/HLh+6dPEQDkC?=
 =?us-ascii?Q?rZZC3IjTGELVMLA0TXt/Y1pqbY7BYn8x8bKh6noH6FWb4mm6Vp/1ylrd+lYq?=
 =?us-ascii?Q?aqkN0xUCc+a7qX2p/BucCPKZ3PtN14Q39MB2DeVmdiE4Oki6MHspc6hYIzME?=
 =?us-ascii?Q?jSmOCTEajMRQDXGq0dxDDxWUeEgNGWh/EsFodrpSlnfHX7k1bdzklJCt9BbN?=
 =?us-ascii?Q?cv14vJ8kUKSm6HxMoNAwbc8riGPG88JgIiOg0uW4nBpPC8d6P0tWEEjB2k5m?=
 =?us-ascii?Q?i+m9OFBy7t8tTpJCZoKWINTk69QeH5DZfmdwtrWIt2cP552zidwU468OZkJs?=
 =?us-ascii?Q?HAD5kohQP69N73Ga03VPHCazgAZ8EnilBZFsGYU21VSdVYeSbMi3mfhsDtd9?=
 =?us-ascii?Q?WxCb1lSRfCxzO9YuW2/xb0bInSWZh2DYInbTpLegvOfI23vniq1RNJne1zto?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff29e608-746b-4607-c122-08dba7d22b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 14:22:11.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJbrtMRqoOxukrnoS05L9gG9ssA0rv20CTYyj4wSf2h9Iu0IEgxCQqDCIcrWGL17nezP73UgYBV3Nvm2LztOC/bzqkLAw21ad4IsYiQ3qaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Tuesday, August=
 15, 2023 7:54 PM
>=20
> From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> S=
ent: Sunday,
> August 6, 2023 3:20 PM
> >
> > On Thu, Jul 06, 2023 at 09:41:59AM -0700, Michael Kelley wrote:
> > > In a CoCo VM when a page transitions from private to shared, or vice
> > > versa, attributes in the PTE must be updated *and* the hypervisor mus=
t
> > > be notified of the change. Because there are two separate steps, ther=
e's
> > > a window where the settings are inconsistent.  Normally the code that
> > > initiates the transition (via set_memory_decrypted() or
> > > set_memory_encrypted()) ensures that the memory is not being accessed
> > > during a transition, so the window of inconsistency is not a problem.
> > > However, the load_unaligned_zeropad() function can read arbitrary mem=
ory
> > > pages at arbitrary times, which could access a transitioning page dur=
ing
> > > the window.  In such a case, CoCo VM specific exceptions are taken
> > > (depending on the CoCo architecture in use).  Current code in those
> > > exception handlers recovers and does "fixup" on the result returned b=
y
> > > load_unaligned_zeropad().  Unfortunately, this exception handling and
> > > fixup code is tricky and somewhat fragile.  At the moment, it is
> > > broken for both TDX and SEV-SNP.
> >
>=20
> Thanks for looking at this.  I'm finally catching up after being out on
> vacation for a week.
>=20
> > I believe it is not fixed for TDX. Is it still a problem for SEV-SNP?
>=20
> I presume you meant "now fixed for TDX", which I agree with.  Tom
> Lendacky has indicated that there's still a problem with SEV-SNP.   He
> could fix that problem, but this approach of marking the pages
> invalid obviates the need for Tom's fix.
>=20
> >
> > > There's also a problem with the current code in paravisor scenarios:
> > > TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
> > > to be forwarded from the paravisor to the Linux guest, but there
> > > are no architectural specs for how to do that.
>=20
> The TD Partitioning case (and the similar SEV-SNP vTOM mode case) is
> what doesn't have a solution.  To elaborate, with TD Partitioning, #VE
> is sent to the containing VM, not the main Linux guest VM.  For
> everything except an EPT violation, the containing VM can handle
> the exception on behalf of the main Linux guest by doing the
> appropriate emulation.  But for an EPT violation, the containing
> VM can only terminate the guest.  It doesn't have sufficient context
> to handle a "valid" #VE with EPT violation generated due to
> load_unaligned_zeropad().  My proposed scheme of marking the
> pages invalid avoids generating those #VEs and lets TD Partitioning
> (and similarly for SEV-SNP vTOM) work as intended with a paravisor.
>=20
> > >
> > > To avoid these complexities of the CoCo exception handlers, change
> > > the core transition code in __set_memory_enc_pgtable() to do the
> > > following:
> > >
> > > 1.  Remove aliasing mappings
> > > 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> > > 3.  Flush the TLB globally
> > > 4.  Flush the data cache if needed
> > > 5.  Set/clear the encryption attribute as appropriate
> > > 6.  Notify the hypervisor of the page status change
> > > 7.  Add back the PRESENT bit
> >
> > Okay, looks safe.
> >
> > > With this approach, load_unaligned_zeropad() just takes its normal
> > > page-fault-based fixup path if it touches a page that is transitionin=
g.
> > > As a result, load_unaligned_zeropad() and CoCo VM page transitioning
> > > are completely decoupled.  CoCo VM page transitions can proceed
> > > without needing to handle architecture-specific exceptions and fix
> > > things up. This decoupling reduces the complexity due to separate
> > > TDX and SEV-SNP fixup paths, and gives more freedom to revise and
> > > introduce new capabilities in future versions of the TDX and SEV-SNP
> > > architectures. Paravisor scenarios work properly without needing
> > > to forward exceptions.
> > >
> > > This approach may make __set_memory_enc_pgtable() slightly slower
> > > because of touching the PTEs three times instead of just once. But
> > > the run time of this function is already dominated by the hypercall
> > > and the need to flush the TLB at least once and maybe twice. In any
> > > case, this function is only used for CoCo VM page transitions, and
> > > is already unsuitable for hot paths.
> > >
> > > The architecture specific callback function for notifying the
> > > hypervisor typically must translate guest kernel virtual addresses
> > > into guest physical addresses to pass to the hypervisor.  Because
> > > the PTEs are invalid at the time of callback, the code for doing the
> > > translation needs updating.  virt_to_phys() or equivalent continues
> > > to work for direct map addresses.  But vmalloc addresses cannot use
> > > vmalloc_to_page() because that function requires the leaf PTE to be
> > > valid. Instead, slow_virt_to_phys() must be used. Both functions
> > > manually walk the page table hierarchy, so performance is the same.
> >
> > Uhmm.. But why do we expected slow_virt_to_phys() to work on non-presen=
t
> > page table entries? It seems accident for me that it works now. Somebod=
y
> > forgot pte_present() check.
>=20
> I didn't research the history of slow_virt_to_phys(), but I'll do so.
>=20

The history of slow_virt_to_phys() doesn't show any discussion of
whether it is expected to work for non-present PTEs.  However, the
page table walking is done by lookup_address(), which explicitly
*does* work for non-present PTEs.  For example, lookup_address()
is used in cpa_flush() to find a PTE.  cpa_flush() then checks to see if
the PTE is present.  The comparable vmalloc_to_page() *does* require
the PTE to be present, but arguably that's because it is returning a
struct page * rather than a phys_addr_t.

So I don't know that the pte_present() check was forgotten in
slow_virt_to_phys().  FWIW, Dave Hansen originally added
slow_virt_to_phys() about 10 years ago. :-)

> >
> > Generally, if present bit is clear we cannot really assume anything abo=
ut
> > the rest of the bits without external hints.
> >
> > This smells bad.
>=20
> Maybe so.  But if we've just cleared the present bit, then we really
> do know something about the rest of the bits.  We could either
> document a constraint that slow_virt_to_phys() should not assume
> the present bit, or write a separate but equivalent function that
> doesn't assume the present bit.
>=20
> >
> > Maybe the interface has to be reworked to operate on GPAs?
>=20
> I'll experiment and see what that might look like, and if it is
> better than doing the page table walk after the present bit
> is cleared.

Converting the enc_status_change_prepare() and
enc_status_change_finish() callbacks to use GPAs instead of
virtual addresses is doable, but makes the code more complex.
The detection of a vmalloc address must be done in
__set_memory_enc_pgtable() where the private<->shared
conversion is done, with looping over the individual pages.  This
is what Dexuan Cui's patch [1] for the TDX implementation of the
callbacks does to handle vmalloc addresses.

There are three implementations of the callbacks:  TDX, SEV-SNP,
and SEV-SNP + vTOM (for Hyper-V).  Changing the TDX callbacks to use
GPAs is easy.  Changing the SEV-SNP and SEV-SNP + vTOM callbacks is
messier because in both cases the underlying hypercalls support
supplying a batch of multiple GPAs that aren't necessarily contiguous
(TDX only supports a single contiguous range).  Batching helps the
performance of the vmalloc case, but the  top-level loop in
__set_memory_enc_pgtable() must provide a batch of GPAs instead
of doing them one-at-a-time.  The callback implementations must also
loop because the batch size they support might be different from
what __set_memory_enc_pgtable() supplies.

All of that is doable.  But adding the complexity doesn't seem like
the right tradeoff vs. just documenting that slow_virt_to_phys() is=20
expected to work even if the PTE is not present, especially since
lookup_address() already has that requirement.  And when
we're doing private<->shared conversions, we really do know the
state of the PTEs even after the present bit is cleared.

If it would help to see the actual code for the callbacks to use
GPAs instead of virtual addresses, I'll do that work.  But I'm
hoping just using slow_virt_to_phys() will be judged to be the
better solution.

Michael

[1] https://lore.kernel.org/lkml/20230811214826.9609-3-decui@microsoft.com/

> >
> >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >
> > > I'm assuming the TDX handling of the data cache flushing is the
> > > same with this new approach, and that it doesn't need to be paired
> > > with a TLB flush as in the current code.  If that's not a correct
> > > assumption, let me know.
>=20
> Kirill -- could you comment on the above?  I don't fully understand
> the TDX scenarios that need data cache flushing.
>=20
> > >
> > > I've left the two hypervisor callbacks, before and after Step 5
> > > above. If the PTEs are invalid, it seems like the order of Step 5
> > > and Step 6 shouldn't matter, so perhaps one of the callback could
> > > be dropped.  Let me know if there are reasons to do otherwise.
> > >
> > > It may well be possible to optimize the new implementation of
> > > __set_memory_enc_pgtable(). The existing set_memory_np() and
> > > set_memory_p() functions do all the right things in a very clear
> > > fashion, but perhaps not as optimally as having all three PTE
> > > manipulations directly in the same function. It doesn't appear
> > > that optimizing the performance really matters here, but I'm open
> > > to suggestions.
> > >
> > > I've tested this on TDX VMs and SEV-SNP + vTOM VMs.  I can also
> > > test on SEV-SNP VMs without vTOM. But I'll probably need help
> > > covering SEV and SEV-ES VMs.
> > >
> > > This RFC patch does *not* remove code that would no longer be
> > > needed. If there's agreement to take this new approach, I'll
> > > add patches to remove the unneeded code.
> > >
> > > This patch is built against linux-next20230704.
> > >
> > >  arch/x86/hyperv/ivm.c        |  3 ++-
> > >  arch/x86/kernel/sev.c        |  2 +-
> > >  arch/x86/mm/pat/set_memory.c | 32 ++++++++++++--------------------
> > >  3 files changed, 15 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > > index 28be6df..2859ec3 100644
> > > --- a/arch/x86/hyperv/ivm.c
> > > +++ b/arch/x86/hyperv/ivm.c
> > > @@ -308,7 +308,8 @@ static bool hv_vtom_set_host_visibility(unsigned =
long
> kbuffer, int pagecount, bo
> > >  		return false;
> > >
> > >  	for (i =3D 0, pfn =3D 0; i < pagecount; i++) {
> > > -		pfn_array[pfn] =3D virt_to_hvpfn((void *)kbuffer + i *
> HV_HYP_PAGE_SIZE);
> > > +		pfn_array[pfn] =3D slow_virt_to_phys((void *)kbuffer +
> > > +					i * HV_HYP_PAGE_SIZE) >>
> HV_HYP_PAGE_SHIFT;
> > >  		pfn++;
> > >
> > >  		if (pfn =3D=3D HV_MAX_MODIFY_GPA_REP_COUNT || i =3D=3D pagecount -=
 1) {
> > > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > > index 1ee7bed..59db55e 100644
> > > --- a/arch/x86/kernel/sev.c
> > > +++ b/arch/x86/kernel/sev.c
> > > @@ -784,7 +784,7 @@ static unsigned long __set_pages_state(struct snp=
_psc_desc
> *data, unsigned long
> > >  		hdr->end_entry =3D i;
> > >
> > >  		if (is_vmalloc_addr((void *)vaddr)) {
> > > -			pfn =3D vmalloc_to_pfn((void *)vaddr);
> > > +			pfn =3D slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
> > >  			use_large_entry =3D false;
> > >  		} else {
> > >  			pfn =3D __pa(vaddr) >> PAGE_SHIFT;
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memor=
y.c
> > > index bda9f12..8a194c7 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -2136,6 +2136,11 @@ static int __set_memory_enc_pgtable(unsigned l=
ong
> addr, int numpages, bool enc)
> > >  	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr=
))
> > >  		addr &=3D PAGE_MASK;
> > >
> > > +	/* set_memory_np() removes aliasing mappings and flushes the TLB */
> > > +	ret =3D set_memory_np(addr, numpages);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	memset(&cpa, 0, sizeof(cpa));
> > >  	cpa.vaddr =3D &addr;
> > >  	cpa.numpages =3D numpages;
> > > @@ -2143,36 +2148,23 @@ static int __set_memory_enc_pgtable(unsigned =
long
> addr, int numpages, bool enc)
> > >  	cpa.mask_clr =3D enc ? pgprot_decrypted(empty) : pgprot_encrypted(e=
mpty);
> > >  	cpa.pgd =3D init_mm.pgd;
> > >
> > > -	/* Must avoid aliasing mappings in the highmem code */
> > > -	kmap_flush_unused();
> > > -	vm_unmap_aliases();
> >
> >
> > Why did you drop this?
>=20
> Both functions are already called by set_memory_np() ->
> change_page_attr_clear() -> change_page_attr_set_clr().
>=20
> >
> > > -
> > >  	/* Flush the caches as needed before changing the encryption attrib=
ute. */
> > > -	if (x86_platform.guest.enc_tlb_flush_required(enc))
> > > -		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> > > +	if (x86_platform.guest.enc_cache_flush_required())
> > > +		cpa_flush(&cpa, 1);
> >
> > Do you remove the last enc_cache_flush_required() user?
>=20
> Yes, I think so.  As I commented above, this RFC version doesn't remove
> all the unneeded code.  If there's agreement to move forward, I'll do tha=
t.
>=20
> >
> > >  	/* Notify hypervisor that we are about to set/clr encryption attrib=
ute. */
> > >  	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, e=
nc))
> > >  		return -EIO;
> > >
> > >  	ret =3D __change_page_attr_set_clr(&cpa, 1);
> > > -
> > > -	/*
> > > -	 * After changing the encryption attribute, we need to flush TLBs a=
gain
> > > -	 * in case any speculative TLB caching occurred (but no need to flu=
sh
> > > -	 * caches again).  We could just use cpa_flush_all(), but in case T=
LB
> > > -	 * flushing gets optimized in the cpa_flush() path use the same log=
ic
> > > -	 * as above.
> > > -	 */
> > > -	cpa_flush(&cpa, 0);
> > > +	if (ret)
> > > +		return ret;
> > >
> > >  	/* Notify hypervisor that we have successfully set/clr encryption a=
ttribute. */
> > > -	if (!ret) {
> > > -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages,
> enc))
> > > -			ret =3D -EIO;
> > > -	}
> > > +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, en=
c))
> > > +		return -EIO;
> > >
> > > -	return ret;
> > > +	return set_memory_p(&addr, numpages);
> > >  }
> > >
> > >  static int __set_memory_enc_dec(unsigned long addr, int numpages, bo=
ol enc)
> > > --
> > > 1.8.3.1
> > >
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
