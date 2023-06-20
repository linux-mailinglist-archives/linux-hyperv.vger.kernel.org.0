Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A70A7372EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFTRaw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFTRau (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 13:30:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB011D;
        Tue, 20 Jun 2023 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687282248; x=1718818248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OoZkmnlV/5ablpWKumO2GD3ZFTk1XPCsrsup5hogK9o=;
  b=nhjAdtq/4t10QlB2KHzqrsE1/aZyeBSJrrHVXVqjEsimTDLp2D5sBxhC
   kLm5Xs19v89G6U37slha2p5pwTcm/PzNPTKyrVRDDvOzHdyZQ8l1/4NkQ
   okGRd/hSrMIEc0jiQtEY+b9F6JHWt9RduiOiv2SvIwFHun2Oqng5lS1bf
   sHNc1piTcYucSsuCSD2ZvOS4xF0JA2Pbq4PxbA9gNk+B05MCzRhl1g8bj
   /nWpcvTu6s/mdX6qeSe6Miu/bY0B9vimc+ysln6voNEeZxhmvVo6fdDqi
   EqUSyenppifCFnG/pbxW/JCBbARAQ9p4GNr69+BHYhh+5++lm+gryHiX9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339546408"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="339546408"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779524007"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="779524007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 10:30:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 10:30:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 10:30:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 10:30:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 10:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfWznzpH79MOPFC7zPa07jGto0MI1rhjbr1Vfj3sW1Owe36ZtbJlEklUS0DXPkzr5Nki6wND+dgOBaoHuuDlAzHGTBk1E4Gx4DWX+5JfZz4jS92wmqDmLaSahPB8uAR8jOtAN2TZ5huNqPThZKiP34Hy6OwHpuQvVscQI/2zEzHTOeAJYYfV2yiymgeYU0sacWAkKZCKcxKFEHpmftSn4Taqb4ziyF3BRinDV8mVEqSETraTi+sUpp/CCv7uTLU6tsuQRLBvvYJQPtMisZCbwsTyufTd9MRrI43At13xWztpTPhrfhMNtrwDcjvdT8pzlvwc6/n3vwyMSLwpk4Irtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr+IR/mhkyV28Q0cFDMkKOoXLKKcOBhlhXv+mJ8evos=;
 b=AE5Xu6n0umMTet37s0MmtJnIv0QzbGoCv3bGtirtIvP5JvZxv5fgCviZov/BIcIEm1/wAnRSxNLXKCKYsua9fW4BJyUAJ940aEyjb5Y4dkXELMILxiv1aKyCWO/SSBZMRqt2NBaDxppmVE9JlGumkaMBrDL2JhDakfmLExTMM+x0C+5d9fCfscvnr7qtThP3CC8n64Tn1wVEYZ7SJeGjWgyntanwSYshSyTAbwEfZpvLz5dWdYw2u9MGuHuZ6BZtG85DB37DNHwGlN28/20OKFV9FXXfGwulnEA7vnV1xqQIIxBk4pBCcG2z1lV1OIaB6xA5cYu3TIadvHyUt9jgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:30:42 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:30:42 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
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
        "peterz@infradead.org" <peterz@infradead.org>,
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
Thread-Index: AQHZowfgzs/ltzhQV02KS6H0RArmlq+TXriAgACUhrA=
Date:   Tue, 20 Jun 2023 17:30:41 +0000
Message-ID: <SA1PR11MB6734113E845FC51ED01CE4CBA85CA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
 <20230619231611.2230-3-xin3.li@intel.com> <87h6r2pm1a.ffs@tglx>
In-Reply-To: <87h6r2pm1a.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA1PR11MB8596:EE_
x-ms-office365-filtering-correlation-id: d6a34217-4f0b-467c-aad7-08db71b4125f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGaDjZqsoSfrji0onD9hTUTnVdHhFHstNHhFifg8AR6maHu9gGEg1/lxg+bocG1s/a3fUBjJvDl5ZsZVQc3cXT8/Im3cgg2czG2v+dRwMvG0iqUBhGI9HThvOBCPZVmmuXh5+HD83yVVpGsgufUGPDWs49FCSDnPvM969TQDIcL8h4xzBx42w7khHcPTp/7b7HJpPRR8szljZe44sHgDsg7u8LmvIHHxnNbmZLskelrl0da9ML6aLS7LeGj/MaweP6VMe6HnxvJrvzRb5C4ZaAjLJSyDlC+5pryP4+cyfEM+MAGs5fmALjWnSbW4Hlx6JoLU1f9iANL5P1mF/wJsBXhvlUQ96UQUou6jWQtyFG61vT/r+uxxCo6lWQGUv8JRu92MzXN19LAqA1qrozxOzPjz+tM/mt1HrtsL9tlDKvcMvd0AvOMbZ2qSsm7ZeZA0n/D/67DOAzefMG170qypUQ8me7SeaVt2kMHpYsRKQm4sxvvgeEmmIDXoMNTvo5ix3KNDf0NLwK5hHLoNy9ejx8bXCcZ4JjKbhBGRHcjnWW5wxFwrhLOdWw+bYirqCMMKzlLVmHvBkwPrAYweT67NBAETwHPvPfkob73rMa2TmSskyv6QVIGNhEnxpVUdvzqx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(4326008)(71200400001)(54906003)(478600001)(110136005)(7696005)(76116006)(6506007)(9686003)(186003)(55016003)(26005)(4744005)(2906002)(8676002)(41300700001)(38070700005)(64756008)(66946007)(66446008)(66556008)(66476007)(8936002)(316002)(7406005)(5660300002)(7416002)(52536014)(33656002)(38100700002)(83380400001)(86362001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N11wu+DVgoFHIBNf7A4Twi4A6I8JO8j2T1uQhJrc02CGiP67ZdvM0vkgrwfB?=
 =?us-ascii?Q?deyLqHEJVMvZseWM654OR6QI2b9wJU+F5RnvtgoCGRF1SsxaKp5CoY6eKlqf?=
 =?us-ascii?Q?lvD2iueidNAGwTQekVAGTUe37hE94toXVTppaQg6/h4NTrxUUtzJHpGE2hte?=
 =?us-ascii?Q?q3QASOslW6VaAZFvd1/4mMtj3khBWS/xiHGYzWVayaSdqORZDdJYFFjqKCMP?=
 =?us-ascii?Q?Qsy9eRr1rtIIJ92KvzCZ8iqka7C02OvhvcQtA15TTsSNTnn2WlGwhzaNbVqj?=
 =?us-ascii?Q?O1gvL5IH33+TccBfvkJE4LzI67tqLPNRZIwdz9wetcWRNcDRXZ5PKm85wgXH?=
 =?us-ascii?Q?rKV9dx0WG0F/kx0GH9m9ulzcdkDA4zKabJVa4Sp+JIABK5lqcPPqa1dm6rTK?=
 =?us-ascii?Q?9jkUvU2hX6y/jGS+HngM2vWhQmxOS5gC5acZPFZ9gJsLw2GHQGumE7EO1Xga?=
 =?us-ascii?Q?CfPVDMCi336+dpvq+LELVHjnYl82pbVF5uUFSYBLB9XwSWMMJUciis+ZLhLP?=
 =?us-ascii?Q?Rvp8wsD/sHmNvDPlbByJAPiUJyv5fMCAoEJzQFUyQH4omzhEv94NPHIzo0br?=
 =?us-ascii?Q?bagd/6ssrriCbEiQtziQGnXkLPKlZudUUCkgxa71nJhRR/dF0ekvcfDtVQAm?=
 =?us-ascii?Q?/icaBzhcbo7vI8+JG5BPTVMPioN2ExivuiKfZJt2sQdT04tOKo+Fk5uKr8FV?=
 =?us-ascii?Q?iubPwA50PcgpnRvtoNFCUPIirgbjkazOTtpG/bInKhlEkodPdRX7WXAg9XqN?=
 =?us-ascii?Q?ccNRsSP1AK76RnjH5wxkvig6e90/oJKjYduZCZWYtq/07ZWLGJQJYQPlSBfe?=
 =?us-ascii?Q?tc9nNhW1WSTEISWHIlcqzgjkS1fM/0r8MqWbycftv9bzLXpBiYWxhUqljxfX?=
 =?us-ascii?Q?WJsHMYPOz2Z3rBSmplY4Ty+gNZE5suPtJHg+lpb2aUmIA8N05NJwwohTTob1?=
 =?us-ascii?Q?BGYA7XwKbIz2HcMA4JYlXg9rXoLzqzsOZtjCtiFoRbNhMAeCmy1d8kM9Iabp?=
 =?us-ascii?Q?kE48gILJeTou7wUnrPcfmMAnhY/tOjqt02nfTO8Co+n+osrTDAoZSJwddizv?=
 =?us-ascii?Q?OMReWKCHqGpAfnEMkbF38Puw0uG9HQnWzhsMHtNf/3mq3x+42yIIh4cHmcdU?=
 =?us-ascii?Q?ZCYOd+jOuDi7/hkYKzvjL+YODtDXGP3ohT4JAg23snu0y+ABs+lVfsVS9GeE?=
 =?us-ascii?Q?D4vvouV83W1jAuVwjZVpxv+9NDoowYCrOUYgpOvlPP8r3Rofun1xF9+ikgyA?=
 =?us-ascii?Q?3rAJmqFaX8CdDlG/OOwVWCBqPhOKeqzdiz84jAgE/GphcSgFYZ8KhQPoDnEC?=
 =?us-ascii?Q?MEDYjw+xzQooHdPoG4sZDijSvH7sdeQTuvdYEkAJARwf5YlUHz0z7lkD/2v5?=
 =?us-ascii?Q?xrDkZfo2SWzxYKIgSVkBvQCOikTPY59bowp8F5FAEJdJsgXPnethIaC6gyoa?=
 =?us-ascii?Q?X+/SAsZc8kewVGWNYMummgT8kFYCKsiQK3vMmH0/embWSXw0D/dqHLQ/p8b4?=
 =?us-ascii?Q?ST/HcvWwvmx0m7O5pv/r/xgjJSfeDCFPjAyet73YQqv1U0FxiO9oNg3r4ELD?=
 =?us-ascii?Q?X0zfWsEASXkZ3koUtOE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a34217-4f0b-467c-aad7-08db71b4125f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 17:30:41.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJcn+6q2INcm1EO8cRvu3spOAlL07ysrY8JsYiwjA+nJJRjlbC+JR5jzluKcAit4Jn7LGnGDCx587z5POJkKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
> Such a comment is patently bad.
>=20
> > +static void __vector_cleanup(struct vector_cleanup *cl, bool
> > +check_irr)
> >  {
>         ....
>=20
>         lockdep_assert_held(&vector_lock);
>=20
> Documents the requirement clearly _and_ catches any caller which does not=
 hold
> the lock when lockdep is enabled.

Peter Z gave the same comment, I will address in the next iteration.

Thanks!
  Xin
