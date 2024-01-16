Return-Path: <linux-hyperv+bounces-1443-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0A82F0EA
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B982B21418
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BF1BF39;
	Tue, 16 Jan 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfO8SDWE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B131BF2D;
	Tue, 16 Jan 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705417156; x=1736953156;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=QfO8SDWEnMtJwjNyyMm2v5JE+rZpyrvo3jqTaDDffdQwjCp0gx8Xiz5l
   L0BgNz7NGebfCx+cwQzcedc+jxIYzG2Z0nTGBNgDvXbgGgM3n7Kupbhcj
   DeiEKOMLfsut2u/nVih64rZzc4giNOdM9t/1YySEp+HtGW2eb4cdodGDw
   BdxurmNRYDDVLyS4db+DkErAjYOBE2nwwXhvfzBE1pVchiX98RfRzmL4J
   rHy160wUN3qz/4kvWcV5I5nnTViP4JPpik+R8tKs7FaSRs/xZXiMa94jo
   fT7KlZbgYzXXY7P7bn6yDOjF4tCx8e1qHSYEfFVfdAtjVrVdsnm+MGV11
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13384707"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="13384707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 06:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="874486573"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="874486573"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 06:59:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 06:59:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 06:59:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 06:59:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 06:59:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdLamZYF2JRlGBCEm/Bk+RiU58vlrHZZ0O2GUDc2c0XZoHU+9ym9akoObJXKpvwICho3TFTSAwafgu5dqgDZ0Q9bHVK7QUq2g/XswVyrLkl9yKBl7o4mrLKZkltQqBPk3yk55zebBotfog8idWRooXcon9hPuhkEFrb5iRzSkuovYEXZI1u6StEmHuGOhduFWCZf643P5g3mvbNsZWNETMarJgTt7Useck3Bc49h0zXvK5AMNQc8XZ6+uj9nvfaoqiJ9OYw2VA4A8o9xY071yUXnOBNXgANtuv7h15KV1rPE9dTKS5vjNUdOZTlCb5UfnsM9aoTDa/2SbkVzm9sX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=luZFoe/hxaE+nXuIY58PsSpEtJKpgVCyOeYkyL08gHI82sWKsOJNmytm+toRhvd4L8Ll55W/h9SxJQSteA/9j3o8P17tY7/DtCisO/dGJOABGojy6yAU3HQGOb15JuBfI14ZLnfsHL7JX1Oxrwo/O4N3tfhQ/BDa7+rcuKp3ZMRMqZQr9yV4C514FbiFCXGg6lOB6qnUn6zmtn5Rf9WH9BaJx0F3q8H8OFNj/ss7FUI/+FWuvbNA54QnwXNIP0CnpO7zjefdfKVCu1QTor9MTLf/8F6Y8LhRE0h5BUQK14AcazPN7s83az4/0m1vqD4zzS82eFsqrTGW7HRtW+BSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 14:59:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 14:59:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"luto@kernel.org" <luto@kernel.org>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when
 changing encrypted state
Thread-Topic: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when
 changing encrypted state
Thread-Index: AQHaSCKY6keRPHV1I0eNsgsaiNq0ZrDciNcA
Date: Tue, 16 Jan 2024 14:59:09 +0000
Message-ID: <c96272439bea6170ad7905490ae96f10775ab1dd.camel@intel.com>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
In-Reply-To: <20240116022008.1023398-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV2PR11MB6048:EE_
x-ms-office365-filtering-correlation-id: 4166a2e3-8b79-4249-fe4a-08dc16a3b171
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4XVbiH5ZRCFWOXfK9VWpjWi2Zav9o+94Uce9gPqqCemlIUGjC7xAsiV6ofHsAyjC5+yNHmdc7YkopHJY6LO7NXeUBvNAxwcoJ2cvaNPq9iaenho0E7vuqd6AKpkSFfxd9U2JN7RhFj3RAuBxCbtWNr9wS8bPTGKDr8/OdKixzhQbKpT63RlcPh5lf+0RI22TJONCVbt8NZYgS+1OWqnxxwb/v1gEOQ4TM5u9ROM6MctDUAUMrmKWI3qtZxKvFgV98yoh8nC65CFdakBIai439pimWuQEfB7NYuaY6QeoYMQZd5w2bheuvd0jI2/ujtRgdXWxuEEjYOpM9uUiizY9iZsDNqL/wr/t23Kf2C2SozxDP0Lja1QEeWMTXb78Asc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(36756003)(6506007)(6512007)(86362001)(38100700002)(38070700009)(82960400001)(7416002)(621065003)(73894004)(41300700001)(71200400001)(2616005)(122000001)(4270600006)(110136005)(921011)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(316002)(91956017)(2906002)(8936002)(8676002)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LtFx71dnuzuvrE4YzctTwi37GcJX1KHUglJ/vXOTLqYgN0/Qq5nQaly3tL?=
 =?iso-8859-1?Q?/tfgn9X2+HtQ39xIhYAeo8GOqPFnVeB7qCdADv/wf4AlfDl7pA0BgwaL5p?=
 =?iso-8859-1?Q?0YEnbF8MAh+NSg9vEdZmtvaP3cT1NU8C7kMedvo1q94dHeClbg0/Jf/RXk?=
 =?iso-8859-1?Q?ZckIF/mfQy3AADu2wqSaRi1nMepgqif/BpcnVyJGrNoFEIQLUsvYQmju15?=
 =?iso-8859-1?Q?x3gA1DE1WTEsvq23iBvUoKizejDyzjDOOTcK8qd2XXp0FmiP0P5AqrgvIt?=
 =?iso-8859-1?Q?NZSNISXFxACKRzp5EtNoj00/Fqz7bQJI9Y1+mVC1fMv2G6aRp0UERbPNRg?=
 =?iso-8859-1?Q?6hXCBbzq6WDlR+wnWm6TCsgnNinSqTUuLze7zZ9dc9Dz1mIDWDj6KTwbCm?=
 =?iso-8859-1?Q?peFxegBks6GSXx8fhhVVWVfAdqABBrLx+ylZ0FzgEr4/fCr5eu1Q3r1ikv?=
 =?iso-8859-1?Q?qj/hUh/DqgKMrs/5+JWFYxBDn9lVFo1o3FEJYPJPE/LJOF+ObyNnXH/GCA?=
 =?iso-8859-1?Q?3Q53p4dHub6XR3b+HgVYnbBhdRzIbUjDMxkXo4NbSX4WBtUPbLZImdbriB?=
 =?iso-8859-1?Q?3voh69u1priTtULr50jusdfASX90/+zBjLb94jbOq1Rpak7NGNxQ6ARUZx?=
 =?iso-8859-1?Q?YPctes58y6dm9WH4ejc+hfGqz8WcWBLKSrBz2+ruREMYPQH8+oyOVRjWLg?=
 =?iso-8859-1?Q?y1H2yTUfrkB4ovqeTt0CWG3qticMa/rX8JHvhz8fepvkAgQjnCdQjCQ/oE?=
 =?iso-8859-1?Q?EOrKlq0dBLpvvMBel3wgMrTgr7saSuOiPyo2g12szXR8cUZAKNGJ7AL8N8?=
 =?iso-8859-1?Q?VNx9zTVbb7hlJqEFLco69A9921+hOv2sB8kbQlyPPMiXI5TT5IyLHUmnp6?=
 =?iso-8859-1?Q?n+JgZgKXqaz50Dffm8SeKFpIULUhap4cQIAguyQQE6s5UZy97IujWhPX11?=
 =?iso-8859-1?Q?21PZagNbQGIgGcru9Q9MBt6F0ae7MZ/WiVEkFTprEppOAuHhqg3vlFJMzq?=
 =?iso-8859-1?Q?tgKpXlA08p3RdgHkyB67KSrQG3NTZN2LFEhTmXQOi0KpK4CQYvZ51MfhHe?=
 =?iso-8859-1?Q?+zt9Fzxmk1vUyTGUXPNdtA6vltIw6SCpdbNjABUyokJzCiQPrmtHe552Uw?=
 =?iso-8859-1?Q?cMIjZ+9q07iSs8vO/eftgXP2ltenArthgzKObAoawD+dzHOxNIFDivWVAV?=
 =?iso-8859-1?Q?ppqwyFtI+HYa2AdbRMrZSWExk0zLWZX3cEm6tG3tL8mSQBHWFevS8sX5rP?=
 =?iso-8859-1?Q?aUuoSfqCdvb1p/3QJmotBFlTNNujBoO+ZQaFgYIMwf+qEOuBGYNVzo9Vd3?=
 =?iso-8859-1?Q?AhHPPYJ1wEZ+MCb29Ehp4rVAKFLxbHQnRoM4UG8kIezARhMvsHWEzKtaoM?=
 =?iso-8859-1?Q?gIn1eXoGb+dzlc2fdxxrajm/mwjTOlq/WLX3DaK1nBJnQqBuS1yG7hGunh?=
 =?iso-8859-1?Q?8RAd054oQjkVGIUAYE7lQX2kCeBLDrdw+m8w+rjn7PFCzyU2krrhtAza9O?=
 =?iso-8859-1?Q?mIlpQFo02f4cnoCYrF1mIVkTubc1LxhC5IqPBw9/R2UNfGkXikDJI+SZzB?=
 =?iso-8859-1?Q?+vn+NAAM0CJPtnpuVL53ew9EtCsFb5wGwD94mYefxYe3Gy4HI1B6xgjFmo?=
 =?iso-8859-1?Q?6ob1L3DAugBlAlgaPu6znLP7WYUEsut1lzVdk51zVVtpPAAfhnKWGDHg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4166a2e3-8b79-4249-fe4a-08dc16a3b171
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 14:59:09.2039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2AHSjxRJJtcZamO4uI7EO9NYFvNU7jmZK4S4cIIzSN2XuPfhkmu1RQMnyfqWzXXZAbZ39y0iordDSx5gt0D9cPmlN9pvU8/ZNPSo1Faeh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com



