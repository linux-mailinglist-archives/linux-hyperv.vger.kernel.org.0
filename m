Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D027A736526
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFTHsC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjFTHrx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 03:47:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE51A5;
        Tue, 20 Jun 2023 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687247259; x=1718783259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AvW6FvDKLs48OB05W5i9A8xyHwB+7rTDh0Nq8MSsEXU=;
  b=XzgvhZRD0r/EORVFfcAq6M6yLx5mAL/XGyszruhUwY3J+SoUeAu8aGPi
   MsvCcsSN5l28hxzPBWlnWqLXwmFemrhbGNuxEPQV4NVDVefRV8+xSMoJo
   znwKT/IVwQ3f3NTyZtpBpekKnN5yXQ/sYAEu6VAvH9Nkk7LbIB80nFPqu
   SoQGkPIHAwLXvIQTZomwYIrseCjw/F6CLpAt8kvKj0ORGwtOV3dF1Ujmo
   5MzPciRvUJpOGxfK2njxHgw5mo9Nl8MPJklYGRG2zWn07CHa+Vs4w9V0v
   zxM24K1zDxoh/NrAgrqdVn4VgmYazNEvAeL+CWgsq+PG5Pda86Ecxlgtt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="446171306"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="446171306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 00:47:37 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="747955902"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="747955902"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2023 00:47:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 00:47:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 00:47:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 00:47:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 00:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvlcR5C6Zp7nT62HdWNe6nG/w4SkQTZOrMCTu0kYstvsQ5gDzll4g+wy28trVLhP62etRJzzDJfHjKALcjiFweiJsUxZqPIkFdJZncZDSceO/HF95nXuaWfHj+evt8CrvvMINIvWh1HNW7NCN/oa1U0nhseRmgav3mEyNkPHGpddILlp6WqEE3KLNhNbc3sJNgfo4Ig7izqR9xkszNXHSwZmDWd891/CBt2BxWXwTHHo3oo2/+twRasr0RlgosXU2N+kZ+2o03rGWnjkQW53VgJKAXx7r8ZKN8dQfDW6MjNV/mgjWi3Zy0LoaNFVK7VSF8foTYUCGfxoGXQLqG9BUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVsdoCEAvMk2DKX+6XFBZiGhYy1UhMA1+hTbGJu1yks=;
 b=REOs8iOhJH3NcnOHeYuwHPB7dQ1EXSFUZ+1jcWhFneea2EiWjpVmZX6nqPM5VAaWU1gYcvMQ8rIikiDz7Vp7OMrHdlma5eNC47klqVxEsRG1fejgCpIPmOnzhr0tWauVCKNzbABv2EVKHJH63xzOD+gWA6snrsRMD+ig7WOchgMi0p7Ctqkl4FRPRM2bOnxcH9kMSc+Ci+YymAGVKmvG4x2fgUivF5S+zPdnl/cVUD7nTs0pXI5Dcxu0sy2zCKYT731dIgA5UK8dTgxrRKZFLDHb1Gqu4LM3tMgP/ws8NBco3k8E4BGAila07rPOye8eIR4ySPUby11ZxHb5do2EWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 07:47:27 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 07:47:27 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>
Subject: RE: [PATCH 2/3] x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a
 timer callback
Thread-Topic: [PATCH 2/3] x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a
 timer callback
Thread-Index: AQHZowfgzs/ltzhQV02KS6H0RArmlq+TSWeAgAAE1kA=
Date:   Tue, 20 Jun 2023 07:47:27 +0000
Message-ID: <SA1PR11MB67340612B7984EADA4CF5461A85CA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
 <20230619231611.2230-3-xin3.li@intel.com>
 <20230620072047.GS4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230620072047.GS4253@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB5796:EE_
x-ms-office365-filtering-correlation-id: aae76458-ade4-4f68-8aa7-08db71629828
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wivGHqueSDiaOjJ0VtzpjaTUMmSfiKO7ydHxzGEk1oZR1t/CDrQA5HttjS63wtWJ5JdqL707cL2TYgvvbol97gxw4fGJdex4jxWflNbG4OtMr1vMONCobcq6v4CDRfhBsTgFji70WNYEzoeePAg8m0C2LD4rODPWdPesFVPZZeGv+7SPM/2Q4edwyScK2lz9XumLBMA1SNfFiZ1AIoB33fSvDI4IFRZeVA6FOFdeG1IV9kzFTenNIh2jMJg3eUHk55y522pQuANiiexFDgolJz50ECbxVXhk4Qjihf590XjvwHI1/ZuByqIGoGIrkcGORLBY3njQF7iZNxpuruDS+KkaKkTxBRusonTutFLUB7DrAlkqjGCKkqK7BcpZ0fS5GrGr3WRQvLmjISdsUxqBKMPlmWMBVGntToq+LRI0aShdJ0AiQb3kTwt7dqf82YuRtZRiHe6rysn3jh7geLkEP6Y7KZdyINNxg1WYKt7QwCY+qGjKvBM2kjKZ+XT1A8UAGF7KRx5FaZpuPpgip0lgq5+djb7gGzoiuuAUDdZpAEge43fnuoV9VfqIzMPCdLFvLjC8HttkjA7SiOqgOdHFKLFZZuBJVpahJUwj2zFWYFmAGCrX90dP+BWCyQbolnXA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(7416002)(7406005)(122000001)(82960400001)(52536014)(86362001)(83380400001)(4744005)(38070700005)(2906002)(76116006)(5660300002)(4326008)(54906003)(66556008)(186003)(66946007)(8676002)(8936002)(64756008)(66446008)(66476007)(478600001)(41300700001)(6916009)(55016003)(9686003)(6506007)(38100700002)(26005)(71200400001)(7696005)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vBlsi7c8Z8zaZntO6c9CzeG5P510qJtmFkMKRgVK1SZEG7kqcJ+Ch1zNqzRZ?=
 =?us-ascii?Q?Vbc4XIyJrKUXXjAuTy7jEqD+N3SNmCwnoLd2F6iK2lHaS6UfCUSueFvqPvfd?=
 =?us-ascii?Q?IMWLUhvVn1/iz9AekpTpoQxJBtfICEJNuVwG9YlyMI7NVyKzFoQK2caOH/p6?=
 =?us-ascii?Q?qBwE7+7VcVQW1cWPzgwyRgJs507ZwziwRqI/zBbBwNHmJKZXs9dTh5UnpSVv?=
 =?us-ascii?Q?CLbB2MqZ0tp/uKNhzHVvOohAHrCKlDagGi9TkfjVygBuX4DZHvHGoGUD3JhW?=
 =?us-ascii?Q?bkYJZGeEBGBKudt6IlRxhu76Bwdf5Uu5vcVUO2mOMcU9vfEc+0bM8wTlGty1?=
 =?us-ascii?Q?jtE4ntbtV2Wpxapt5lIFtwZVhSZ9Z9LJqPwjZI/pwtuz5uDTyaJBxH+fX3vt?=
 =?us-ascii?Q?NSS7X45fDoVtdBLS8ixbYXcU+DisxF+qSRBC2tm4f3lUFOrgoTCDWBoNiZyR?=
 =?us-ascii?Q?DYUFlQFYNyQOZfXf0qvCRBAZQUtK2nkWhfzwR9g/mcRClBsK8No1lyPB0EgL?=
 =?us-ascii?Q?7U4LxIrCGhh7e5xoU+zXRgJp0qKcc3G06WkTD/fNncVTHh7zE4wp6nDZlQpt?=
 =?us-ascii?Q?11o4tZ48rKosYyTRBMNqyJmIF0pkapiiRYAQLxM/oo/aAjT38pHfEhh2k9gO?=
 =?us-ascii?Q?fqy5q1f5Vwtvo2n+eDVah3uIRSZ3Q7cdG29L9YjCJVwm/g2Ki3JkhBQ7c8RD?=
 =?us-ascii?Q?Std/UwlmtiRiMNJ1dyarjA6ksLND9y+39zMJQfZRSm6NuqosYP/0yAX1b7m5?=
 =?us-ascii?Q?AUh9YhWr39OvpC72evzB0+W6+xfhDIfgusS8CY73mCtTLz2jF98YNkfug/Mn?=
 =?us-ascii?Q?9Ka496je0uocUzNAJhv/U9PFy4nDMaYSzXdK7e/lreQin0H+saNW3Y5l//+t?=
 =?us-ascii?Q?j5i6KplkAcRiC/+FxSDp/WPzLnTcvmNZOdx0DmHOdoZd2E2YbQ7ZLA4iDz+n?=
 =?us-ascii?Q?mZUNlGHbK5qtD3EWwWdavlPrZJwlZMQ1DICrmL2qUvJV+URlTjXo+CEz84pW?=
 =?us-ascii?Q?nH7IZpwOGx8Evm9DmkXYFuwHkfpuxi8mMGrmGA/lHDSRLjTPI5EdZjQvFYPg?=
 =?us-ascii?Q?iBsSJsxLP9k8ZBg4WhIvt4zTrjlsCj9ArjF9V0DDp/HGQtUOErMFgJo2ezzF?=
 =?us-ascii?Q?BGBxTR2ytyLpFq6dz7B+1EKkC8w8V+MqkyyHwzeJvwdmCaJSFq+YmGqTEIG1?=
 =?us-ascii?Q?b+pyfjtb5K8AIU18m0TqwJtz7MV8KHem4A93RRnj8v+bUVf1BmulSwyQbJVm?=
 =?us-ascii?Q?6sITa/jGqvT/iCbw1v2vbwnYaCg7LM1Cbrft7/Kkan7GzQmiO+YbdLkrWwLX?=
 =?us-ascii?Q?KIoTfPJDlruDvBaKlCvhRx8jthRlq7/1uvLCf4vyr/LcYz1WoYBkBzapaS4/?=
 =?us-ascii?Q?iac3PU07WJOZ6zZEVF0DAKihR+2bODAADcsLMPoaSr5ZpvAcgc4ptggYej1i?=
 =?us-ascii?Q?0qDaqgErisPJRFP3nNXLj1ZeZa9UEgXMx8CYOi92dWZIWXtpmDlOkOJ7VzQD?=
 =?us-ascii?Q?XqWBmnMx9DjwcI/J+H+Ux4AJG3VUQm4JuWFK8tIDCCj0IIKCvNShA6keaQno?=
 =?us-ascii?Q?fd5LZGQz0faAxavvQxI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae76458-ade4-4f68-8aa7-08db71629828
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 07:47:27.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bl1Rc+yY6SuX62odDsvZNx5gsYgnhxQb+4zXBonOExCdOa5JPHwWdANLKfYkyg5GM0RhpOtpTm2WI5ILtF1WVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +/*
> > + * Called with vector_lock held
> > + */
>=20
> Instead of comments like that, I tend to add a lockdep_assert*() statemen=
t to the
> same effect. Which unlike comment actually validate the claim and since i=
t's code
> it tends to not go stale like comments do.

neat, will do!

> > +	bool rearm =3D false;
>=20
> 	lockdep_assert_held(&vector_lock);

My bad, didn't notice that quite a few functions in the file already do tha=
t.=20


