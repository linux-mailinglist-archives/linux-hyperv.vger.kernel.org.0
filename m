Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5E6B7767
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Mar 2023 13:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCMM1L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Mar 2023 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMM1H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Mar 2023 08:27:07 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF162B5B;
        Mon, 13 Mar 2023 05:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsgilusxzhFl9lwtREjvmZ1TKNAgwkc6NXfL+rhFIjFz2pTwKrgXHSs5Gmw6B4EgB6symFdktrRlZRyPTmy5fnahmv0oa8o44z+ghQZY9yurCcSf7Mwt0u6WI/yL5vmXZWg+M4Xiqh/LyUo1FGNsO9HwV0N4uzavQvsv9bYnolupWPyPKy95rZhHU77Dl8Yz70deT56uo/0EbmuHBVijFgxZQO/2otargefofbQiOOtPW/ajaU+PoHHFrWEb8XcVedM2f/2ZGhT3xuRQe/B2c5yAJDJzKmcJ/I1BpEPBMrnSc0BuT7BCHziPTFwWsJByTFy4/8RQbY+8ezALp9xE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak8lwkLMIvBHnoABPvlYF2ckWXhkrReT9z/PxyXty84=;
 b=dujjbKUbHXxXp2rBHZCgOQaL+JgYgQm2AIEy7Iv2c7c43aL4NplKV7C6DLGn0JzzLaCuKBpGnP4LGNLzgpb+X+2wd/0Up+sFynk/qqQ+FwqI7hpOUJCzcCB8Zxgw5vYZdHwmoG9SGoBalA240ajZ1gBXEcSBeugWp6BYcvP0zMQi7K/1I2xuw/6FFhd+GtWDt7gdj70TSJJUM+nJ5toGxqiMeXuqN5cUT1LzZtZ7Ayha+JrH48ysNU2JSgU+xKBQT/jerpfJhFkIhsN1Yz1yKFE5LDagDDhtw7EmTzlwrCXWZ6VyPWk3qnlXL8OdP7xMjSgDJqeZZ0Hqpa68Fr/yKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak8lwkLMIvBHnoABPvlYF2ckWXhkrReT9z/PxyXty84=;
 b=AUp9Hl3U8YnLw9dFvqbPOsgq/9Okji34uL8MZX4PvskBa14t1JHaSAarXJftP1mirqC4p7Ztv1EGtY7tamJmJ2y1dvj67lmb3jP/aLizrEaVDvCuB+Le/qF+rMkenxm+5iI5Jh9AsW81sPO7fgeWa0CEd8uyD7ueHlT8yXvyRsU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3049.namprd21.prod.outlook.com (2603:10b6:208:371::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.3; Mon, 13 Mar
 2023 12:26:56 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6222.003; Mon, 13 Mar 2023
 12:26:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Thread-Topic: [PATCH v7 5/5] Driver: VMBus: Add Devicetree support
Thread-Index: AQHZR3oO8XCRAJVOTEyd9eleCYLxd674F9KAgAA/zYCAAGYrcA==
Date:   Mon, 13 Mar 2023 12:26:56 +0000
Message-ID: <BYAPR21MB16888AD9A473CF15250B59C7D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-6-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688B84E25DD2173B6023737D7B99@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230313061603.GA8934@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230313061603.GA8934@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=61f91c06-2473-4543-af2e-e09a225b35f9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T12:21:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3049:EE_
x-ms-office365-filtering-correlation-id: c5b3defa-c491-4a4f-38a5-08db23be3c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nY2gUfwzVaaP/qKEK0odu7CrW697PyIf5R1+8ApPDVk+2vGSuoad3XeFAGB4Eg7aw1mPAVshC4aq340KcS+yIh3h3wcQp+UNrxWyrZZBV2NW+WAMW+0XsnvZy4fkCfFF14ZFvdwv5LKvVkGEfIIBgUHy2STIAAJIjOabaDls4QqwRvVGs4l6GAG/lX5UyppoV9bQN36Y+5Wot6cVU3G9YdppUVxN8ogNTG6tiGLsBlFu3Mpfar//zNmidXWbXMn4sQcuQefZSydU0XOQ6kvAFuVccnNRduNAobGBxBQzIa970EFtTGJON5v9oZFz2pOagYaKoPycR0IgtZUPaDMi1DJYFmlR6LZY/PrYe5bYwWVhPEyIXXKE41yCDRksKEbGRhcjViBf1SNSlxgYfE/0EjclrBoLuQ3ymWWSdimUqW99H08P4AjXHQ6EYNH8+z5nH4Ytn3kamQfz4ALh02DFxeDsGeUHzFWl4PMv9sFONW2YGvfxBsCDms2ZomP2uq3m+dffVR03vOmoa3XI4ADVXrSTuIax3sYXY55o1NNf/stv6ezPNrV1brAhDW4wrJ5JpFGl8m84Zy/D+BLJKswroN7inw8MgitgRF1quBHQgN1mF5+Xu+LoCZ5j/q0jgNo7MWRfmdfMVyWL44EtI/BqLlZlOGIcoDEg2V5JD06GGVeUYprsNERdacEsjyYpuPenRMhWMYQS10EhLOYO2t1nln9zfzgy+PUOUTWFXXw+JWUzO6x17Dna+zEJT4LLhT5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(5660300002)(7416002)(41300700001)(6862004)(52536014)(55016003)(33656002)(86362001)(38070700005)(122000001)(82960400001)(82950400001)(8936002)(38100700002)(2906002)(478600001)(8990500004)(26005)(6506007)(9686003)(10290500003)(83380400001)(7696005)(71200400001)(66556008)(76116006)(66946007)(66446008)(4326008)(66476007)(64756008)(54906003)(316002)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pCqWnRZ8ojtKBArdX+OmgEiz5T7/BIopH1sghelPKBLJVa6YaEn0/GyF3gtY?=
 =?us-ascii?Q?zHKMhBE9VtRavMbuE7gEbvQbXKeU/ysjgz0A+cTPgF/ucoroEM2wnyuySeEb?=
 =?us-ascii?Q?jhWbeMLmghTISzgJW4YHfPSibe6Btqg1zsH7VGCq/bJIgCTBGrj+Ae6wRggz?=
 =?us-ascii?Q?javcwHHOFPdmR75x2kuGJEPOVRgXDpw3Zc9+t0CRAkALSDJ3HX33bGs9iFq2?=
 =?us-ascii?Q?6SqaVE5wiHNVPUYx+UsMdZWKyOdTqn9sqA8XSWIx5JtQcF0OO2UaxYhSnlwW?=
 =?us-ascii?Q?HvBYOwrOOAXlsplfuqI4f/0BMBRblAVkPRZlC6JNSxCB4SyNMhdo2uTKsB6W?=
 =?us-ascii?Q?SHfztuMpLKgR5eLMWuH/oiE+WFSVMBpNrKWHe2mzbKnM16ptroKVZPIsK3vl?=
 =?us-ascii?Q?XP0o/MkYzd9Bi9M0LdglpgwE7MNELjx5dbA9KnQ6hcS8Ww06DWyXO6rnRrpt?=
 =?us-ascii?Q?teV8djrhJEPjbx+D7j7HM2IR9whFSlh1l0zXCnTLdynSaPX5p0ILBRBLCdOD?=
 =?us-ascii?Q?WogbvReAVF4CpOoSd4tHBanWdx9Se3VhKI+4/9FDtjWb1365GoUMAK4RnMNf?=
 =?us-ascii?Q?0BV1Hp1AgS87melG10udxBPItZtpC7ohub+yc6cbY7z8HsYy7etuJwSVcNkR?=
 =?us-ascii?Q?teDgYMbrrygyWeLEdrjefDY/HG2rn51g+4TryPquZ8Sg6brHsDNa/SypGrt0?=
 =?us-ascii?Q?vrJFoQjxDWELTcSYy3n05Ar6qf+jf1RonF/HSEpceF5AmOdeLXViU4+44nME?=
 =?us-ascii?Q?KCig04soN8KvvuHvsMZPsHEoVu4OitiMrrmJpj8ojeXa/kpUE4vBvFvCx6dF?=
 =?us-ascii?Q?OAijKE4woFk8yZ98l3474L0UiTShw2TQREFIBagWG9O5eYAm7xM56Pi0VQFK?=
 =?us-ascii?Q?teh6Xd1mzCo8g9ohq2x4PBDNsXdJDRBqMXqryPK1FuWRzitCfvgt/auHBPzt?=
 =?us-ascii?Q?aqJQ9e//In9y6Q4a5PVL6eXJ5XFbV/mR/YGpvi2I19/NrkypEJ3cni2QrYPV?=
 =?us-ascii?Q?obekdQvOgGw7gR1zZx0r57K7BMyYmDrR2Z5ClvMoY4uUGXoozkalw9rcsxBc?=
 =?us-ascii?Q?6TBUrpxKn97Ci7AgMYG+4lEjFZ/H+GkbEK9BNyuhFaMqNK567Wpgb043S/wP?=
 =?us-ascii?Q?ZYMtCaFBrsXzIOZTS6fzjJajzCbEh24CkFMFY1Sjc+FV9JVdlmIgovvoFxKQ?=
 =?us-ascii?Q?dfCx8ktpxXlB2ReNCm3inV80HY69UiPNdo0sJL/AdFWHPW1bN4mjqVw8C3f5?=
 =?us-ascii?Q?5tpxFuly07lZs4wnLmuMxakcKsuYqoaiMaWHqz9jk+7LkD0155UonZX3eQfo?=
 =?us-ascii?Q?igoLnXrqAfNjcThxB+5uTX6d8+8ySqPlWcUAjxCOqn39dYNM/t2B7pqQyX54?=
 =?us-ascii?Q?aQoGPfD00FbskXxtHg2ZVQkxQX3qYfXnpaZ9/fY9hg7z/YuHZr4dnEj93wrB?=
 =?us-ascii?Q?2YWyh3Gn96b8kyT8rZNIpsrrwltpsHPUP8pkLR51RhIUyyf5YUdmUG+0KlMk?=
 =?us-ascii?Q?us5IulDtNbtp6eemhZ7vHjLS0HIlWO/Uso4qxo5IYiUr5qf/pa7gTonxr1vU?=
 =?us-ascii?Q?TFLvE+rbDyZ4oauISinRSkL797KKJylhASMjZR7IoCbyUtgYtzA2ppFpdpyV?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b3defa-c491-4a4f-38a5-08db23be3c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 12:26:56.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iuGh/VIR1qN843yz5kBSMfffAl4QbjDI0YLNBolTUpJEwxbQPobPDv1tENFu6dcK/rxosfVDpA34Sv5ckHEyOAnOgyP/8EDoiDu2G/qBXoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Sunday, Marc=
h 12, 2023 11:16 PM
>=20
> On Mon, Mar 13, 2023 at 02:33:53AM +0000, Michael Kelley (LINUX) wrote:
> > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, Febr=
uary 23,
> 2023 3:29 AM
> > >
> > > Update the driver to support Devicetree boot as well along with ACPI.
> > > At present the Devicetree parsing only provides the mmio region info
> > > and is not the exact copy of ACPI parsing. This is sufficient to cate=
r
> > > all the current Devicetree usecases for VMBus.
> > >
> > > Currently Devicetree is supported only for x86 systems.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > > [V7]
> > > - Use cpu_addr instead of bus_addr
> > >
> > >  drivers/hv/Kconfig     |  6 +++--
> > >  drivers/hv/vmbus_drv.c | 57 ++++++++++++++++++++++++++++++++++++++++=
--
> > >  2 files changed, 59 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index 0747a8f1fcee..1a55bf32d195 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -4,11 +4,13 @@ menu "Microsoft Hyper-V guest support"
> > >
> > >  config HYPERV
> > >  	tristate "Microsoft Hyper-V client drivers"
> > > -	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > -		|| (ARM64 && !CPU_BIG_ENDIAN))
> > > +	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > +		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> > >  	select PARAVIRT
> > >  	select X86_HV_CALLBACK_VECTOR if X86
> > >  	select VMAP_PFN
> > > +	select OF if !ACPI
> > > +	select OF_EARLY_FLATTREE if !ACPI
> > >  	help
> > >  	  Select this option to run Linux as a Hyper-V client operating
> > >  	  system.
> >
> > One further thing occurred to me.  OF_EARLY_FLATTREE really depends
> > on OF instead of ACPI.   The ACPI dependency is indirect through OF.  S=
o
> > I'd suggest doing
> >
> > 	select OF_EARLY_FLATTRE if OF
> >
> > to express the direct dependency.
>=20
> As you pointed out OF_EARLY_FLATTRE is anyway dependent on OF, and thus I
> feel this check is redundant. I see all the Kconfig options which enables
> both of these flags don't explicitly mention this dependency.
>=20
> >
> > Separately, I wonder if the "select OF if !ACPI" is even needed.  It do=
esn't
> > hurt anything to leave it, but it seems like any config that doesn't
> > independently select either ACPI or OF is broken for reasons unrelated
> > to Hyper-V.  I'm OK with leaving the select of OF if you want, so I'm
> > more just wondering than asserting it should be removed.   I didn't
> > see "select OF if !ACPI" anywhere else in the Kconfig files, and it
> > seems like Hyper-V would not be the only environment where this
> > is the expectation.
>=20
> Ok I can remove the !ACPI dependency. Hope kernel size increase due to bo=
th
> the code compiled in shouldn't be problem for ACPI systems.
> And here if config doesn't select ACPI or OF it will assume OF, which is
> better then selecting none of them.
>=20
>=20
> To address both of your comments I feel below will be sufficient:
> select OF
> select OF_EARLY_FLATTRE

Actually, that's not what I was thinking. :-)   I was thinking for the Hype=
r-V
Kconfig to be silent on selecting OF, just like it is silent on selecting A=
CPI.
Whoever is configuring the kernel build would separately be selecting
ACPI, or OF, or both, depending on their needs.   I don't think the Hyper-V
Kconfig should always be selecting OF, because of the reason you noted --
it drags in code that is not needed for normal VTL 0 usage.  If you take
that approach, then

	select OF_EARLY_FLATTREE if OF

is appropriate.

Michael



>=20
>=20
> Regards,
> Saurabh
>=20
> >
> > Michael
