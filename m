Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13274737301
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFTRee (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFTRed (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 13:34:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253CDA3;
        Tue, 20 Jun 2023 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687282471; x=1718818471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e2o1S+sKExaEXn1ZV6nZyxSHhqPdkcT93L/bOk9KogA=;
  b=URwFkDqfh5Vtd6EazEHpcrHPgPFbH5pCU1ksYzmr31vKHsk3rjZeR4NN
   4AEwUm/BW7mg5dWWxUYOvXVW907/6DNICz6eGG8pGiZm8mxduWI/QgFGI
   Er6M0zGtMpTX3ddoS7iIQ9Xy/J3+jKaRqyp4bd9xkqyCf3Lyb2Y8SEaJe
   HOSRVCHV3ZTnvdhLvqgrD5v+3QNPC/B7R60OxewITl5A61msbiiZ3XAF9
   ooRa2ZNNkPREVq0sgsoUHCwMFhlwR6bYTY72ExEUtuXBpD+frqvNJjKDR
   glqDJ3us9KUuBJk1g8dwFL8S6kErBAUBTr7gtOTNICG0cYqMpQzjeEJb/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363354165"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="363354165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804029333"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="804029333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2023 10:33:53 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 10:33:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 10:33:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 10:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8Xi/B4+mSZypBZDUU2ND9NUA8xFB2dPIiVLbClahsBvHsHqIeaW+OqI+raPNKPOA3RoVI1YsfHT0vj5TlE7d6XejR+9Xd2NJKuUJHWdzvzfvYaO/vDLy6WmtQEEeo2fxWkdtR3loKwfjMoUWn24Mi5g/Sr5zIi+pH+V9huoDNR/iFw9fkvGVp4gpJpttHn4I5Jt2yKx0pqH8/K5Igd7BCx5pdULR6LgenPLgXeaHoZoaZW7WxwQK9cqEVWR076ucdtZ1Cvk7bLe3qxU7vPpsSa1+5ke/ngd1cpbZClpjZlhnMwIY9na5dsiw0wskZABgznOw9hTjVkteecoFUO5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOfcSklZ8fCYfzrEQ0oEPLp8HM5G+qt6AmeF2jigd0U=;
 b=LrTzBe1YqCKAYTBl2vQ5g/4D81ZLmCAVbHLK15gYuyF9a7atvWzMjhbKtl/Gx/QiFERk9/IHkouV37SVbTKUnK+X0eVy5s/q41NKfxqwStyMZupAyVUw3q4Ik6b16OsEvKbmYvZwOos3ufsuQwzZjxCKMX20drdKeu6ma5S5PLK8BmEtEJqjVL/avWpje//XdxmfRh/DjcBBF4zG9uuKre45+ZcF/ZIRxdz84UA4OfA3OktxWSUjq+K9MxDrXxTcuLZzSdSyz6UMxqNa/oHAKMF1d8PlPLzgeZfaxNtiVrcruiHjwuOBWmocgALWsSb1BZbljuFADxUx6MRmSvEshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:33:45 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:33:46 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
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
Subject: RE: [PATCH 1/3] x86/vector: Rename send_cleanup_vector() to
 vector_schedule_cleanup()
Thread-Topic: [PATCH 1/3] x86/vector: Rename send_cleanup_vector() to
 vector_schedule_cleanup()
Thread-Index: AQHZowfeI8fQPreObE+J5qFxBiqZxK+T4jSAgAASHOA=
Date:   Tue, 20 Jun 2023 17:33:46 +0000
Message-ID: <SA1PR11MB67341EFA507898919165D050A85CA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
 <20230619231611.2230-2-xin3.li@intel.com>
 <ZJHTYUrKA/mclxRZ@swahl-home.5wahls.com>
In-Reply-To: <ZJHTYUrKA/mclxRZ@swahl-home.5wahls.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB7579:EE_
x-ms-office365-filtering-correlation-id: 61878690-0f31-402c-5f08-08db71b48053
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPZ71XkbcShJck3mfxEt7T6d10xJkI0PkwU8SgXUJdisA4kNMXlpO+8qkTx0/4kI5ZUZQDNUkinoZ0ZLv9wToixRVT0NGN5ITFOL3u25N8xpR6YW1GRI4vn3A8TjKxHrPgc19fmA4/H386/Jz/2TIbDucV0aDs4lQZWNUaYpV+nF0hkOtNWnYHiIpJioyvmBOw4XAxLifXoPwYWH3e2fqMKlEm7EZeVCNmfkKvWExffifiYuu2z/8OHyrAvGGZpG6XJLBQabwS1sdrdL+u6U/JCgWM0ALVl25VpnpXlO8Vo3RrtfcqhsKDM5bVTr8/5cELEeKUAoQLXtFIUo+FiySKBZjarlANXLIMmB04rQltmo8Wp7IE9Ou2f+Qjz0YRNVwbWd+RhU5JrGyjhzbdojXCFSRmXKoYg6b2WpoPRbu4QNWxAAO/U+z5CR7v8b03e3cs5LUVdUF455DlKtKX9RILrO5bbK/EwSYNveQneHvOpkR6oPvW88zrN6gSamVJNRV06X+ASWyBP7ZCdvlyR+gHZxf86aznDB3UoInkH8f3my25QMZyj7xMv5Je55nYUvt61dz7P1uU2wP7XiMFnUQMtNCFQFAovW2QMJzChviplXTyqz3YHGuSztyxChT2Rg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(478600001)(26005)(7696005)(71200400001)(54906003)(6506007)(9686003)(2906002)(186003)(52536014)(7416002)(5660300002)(7406005)(33656002)(558084003)(38100700002)(122000001)(55016003)(4326008)(66946007)(316002)(296002)(82960400001)(76116006)(86362001)(8676002)(41300700001)(8936002)(6916009)(64756008)(66446008)(66476007)(38070700005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eE2nZo9FtuqFW83TLZYybhWTz1veaeVrSjlgwvJwXJGufkjFOgyxqCiIgpz8?=
 =?us-ascii?Q?XDinYgO6sZYXkTPgfpRLw7o5F5mbjVIGH2ZI3pCJF8sf0KmH1/ietIPoEVTF?=
 =?us-ascii?Q?688bhHszyjotwJ9OKccupqfQlOQl8lArVWoCDaxz43TSLHJtBN+iu1RQBn0y?=
 =?us-ascii?Q?KGRkyD5/s5kfaFmzHY/10y3IE09pwxlkohI+IeB8ozRr4a1GBnfSkN963Alz?=
 =?us-ascii?Q?dn6kf9lovKKcUZPBfcHAdhWPcwCXpixeJBsVizLN43g9uweGJVb/36uFGnsL?=
 =?us-ascii?Q?aSQvnbD2b4gKkXyvTpC1RWY51P7KA04DS3ycFW+GMs2loYXiWMluXDaOVWd1?=
 =?us-ascii?Q?16LWMaGSqciSu+ODflDhqT/+QtsCfWGJFOvG5dSiOQhG2Hc5yByP6OfuONCG?=
 =?us-ascii?Q?mtTU8QVk41YK9B9axQ4xGWpN0kVkJPFhbBDzvBdx588AAj/dOJRP1ypg6ODR?=
 =?us-ascii?Q?fqR1eAWuPoNdkG+CP2K6M3gQRjlw4Oc+vm9ptXszTcipd62/4gubWP0dInD6?=
 =?us-ascii?Q?RzEhplfCRnlcOYNDWGyb76Hweh8NMbKBM8HXuRcZbpTTC0b464VbUMYb0tVF?=
 =?us-ascii?Q?LSZCI7Zwzz10GyMLwo/gNkC1gUZjkYzg70iDFqJLjVoNcCS+3hQKXrel1GNp?=
 =?us-ascii?Q?T646gqUEgw2/3zNsDjaZ+QR4Ujlr0attbMIZuECHdo2ki3ztmSOB2p5iLj1i?=
 =?us-ascii?Q?gaSQAgECZvZelv8JM/kq5DXaBUgCGjZFTCVAl8XT3pPEFWgQ/IjAbe3WjJzx?=
 =?us-ascii?Q?lDLW5L48/Y+pWLR86KyKR1A6ct8Hu3xii+vJ3HjCmXNdw0aBJlZEZZLdw21v?=
 =?us-ascii?Q?A6Gye9ZX/demXX2691rJ+9q1STKVrPZ6/M4q0c/ahezfpUI6JlDVCvpww91O?=
 =?us-ascii?Q?omtfZ45C5Yja0wFz7YpHnwtG98nlZ8C/V2vc3SzlZrI77VQaN91XQudF7i/x?=
 =?us-ascii?Q?RpITm24mUXnhj9jhahFGFArTGhlzXob6x3gZhmdK3WKdNs9UGJR6eCIbShPd?=
 =?us-ascii?Q?egHp2pnptEb3kvi8E7JcEseEbxYMpXbdkVuRvY5oNnWaVmq3pjKE+9c5yZm0?=
 =?us-ascii?Q?xmbJVNXQlAceP6bxEo4um0x+OcMayhLJpQCgh1OhNMRY3648DwbZk8wAfHym?=
 =?us-ascii?Q?4LubcKADKO1yAF13mOXq6ZkAVvKOSC3vXqliwS0/K1eY7gnbvmrrr87Omkoj?=
 =?us-ascii?Q?Cfj9nwcteObMcT+AhlVWMXKXxpMYc7P16lPxwPbHe6BHFFhBgYuHLYwh7N2Y?=
 =?us-ascii?Q?cth8XqStP+cPNvuDSve+PY94zzbytaEEGSWLdh89nctXkx9UMS7Exf5iPBN3?=
 =?us-ascii?Q?fO5bIw0lmh4sZGfLdLr4MmBUrJLUP2pu0E1F7B1o0P+vdoePElQ6PDnwErqD?=
 =?us-ascii?Q?Rgj5ORX8zV/cSKTynMfefubidGHd0ao/1NA5ZWHX7n5W0bTzgIDsB8KQxyRb?=
 =?us-ascii?Q?L9GAGJhZ/QwYYKpVsI2RnnZqs6jw/LYYe0fjhE6y5jueyYdAJsVWpoEe9fSf?=
 =?us-ascii?Q?AL3iVciHzyIQiUQKaTNoo+P285TEZJuGhbWcafvLgvsAZeK2XERgx+9W7ddF?=
 =?us-ascii?Q?CJQyDT09NrrJwmzSZvc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61878690-0f31-402c-5f08-08db71b48053
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 17:33:46.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1a0BEx7Ms6D8cbaQvL3AYv49ILGWzIVqN3TOPB0V8Wk3cpNVKKbXDPZFU1y9ZAcV6qlKCgoWScDnpUD9u6+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
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

> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

Thanks, will add your RB to this patch in the next iteration.

  Xin
