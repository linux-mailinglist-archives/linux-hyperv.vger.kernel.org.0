Return-Path: <linux-hyperv+bounces-1640-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989B86E944
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E71C2298D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC039AF4;
	Fri,  1 Mar 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2ZDwPPf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC85848E;
	Fri,  1 Mar 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320410; cv=fail; b=lqouhgmEw1Sj/88hNu6jjdt31kjnpb+7fls44Rta19lwVgaxEnbp0ojr1P5wbrLvDTXxAFlFsCtbIB8/5wCkz7TRu/KRHq/+/8aDLYJu6R1+zNCR1+3lF+YCCanOmJBoH2K2MhG3iLy0T776iGqd6GrOUtjkMP7CL6vjTuaiuNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320410; c=relaxed/simple;
	bh=mInuwtUNL3Ttw2fKGzkZ+hQZUko98V62OpM55W2o588=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rRDkia4zSy3D2OZbjnJFWgQCzpIEI3+d1UBpuo0+UaU3fApttwFLnhon9jVrnXVg4lMvXGnSGLki/vVtI7uGaqUom7MaGCtPOCKH06Ot5UboS/B+EZsuDM6fa6AylX41PYgh11cuZ6Mcz4sdEEqyWZ4w8hdqlA78bh8XifAKSdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2ZDwPPf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709320409; x=1740856409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mInuwtUNL3Ttw2fKGzkZ+hQZUko98V62OpM55W2o588=;
  b=m2ZDwPPf1l8Tzf2CxwIyWVnS/lJ/FAWwNd0ntbK6bPreADk2sHVqIpNN
   Ydi3jfapGHVyxrU350BUO1hbr/V4hXwaIe9VE03kf7DElCKcu43zTZhbx
   WH3PlUVIO3SoMmftYb3xSaorKfeaj5Oijajrb3sa7wm2GKleS7jiKlvAl
   cLHmWwWlnVvMf9mb9ne6ZuATZfFdfaGSqhZfPBCIg7eWXRcsR70R83Bsu
   x5o2yB8xOIyq4QqM5UQMzSz5gTnzUGrUYbsdlrEPzHBBDeawlljts1uv2
   8lxo6Orz+NzkhwkTDlZAj8f+qx1m69edrTQPv/seZ40m4DnVbrX2Wtbho
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3738061"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3738061"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12875860"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 11:13:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 11:13:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 11:13:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 11:13:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 11:13:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7sagPXnojlkKSPQjprbxdD1ytUgZKVhiIf/xvmLixWQetqq5geHJXFJLaTvLt6+AoqkPZsljMa0WiKYgWg+6Fj6RTHE+22NpqiT0mCMFMpSdQvVfWYCioKIq9hbAQb8kvNY0efFGyPjUiD49i2CJsEBFC4Hlyq8XHHkniky9mksZFGLbaIz/sPIhjbvpxGfSNLg9zfHq0LohvMVxQ5EGotfMBdfZtZ6ek9rMsmzsKUYGv8bpzHU/9/ozN0jBa5fLq+Xfn9ftCt99/M1IKo95EJj6jXYCmFzJD15D9DSePE5pOpZS7X0YQ+SYyYl/Mk9hMTgne9TRuzgVqV8157ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mInuwtUNL3Ttw2fKGzkZ+hQZUko98V62OpM55W2o588=;
 b=E9OBqNLsXortb9eFHYNy/+7O/VdoaQtxRyUn0vxVwFVKCw1neBZ9J9OA6De9w9zW0KDgjPPcspe2GFUdcPPpOeBki+JE0OsEp980SBbfI9skrk98bzslMtA/6ah8A1iWeOK6ncBUeDdF8y7MCKnwNBf3f9IifBXwsQjuLKzZeub90s3QiB34R542TfCqKO/SYTDKf510Z1pgbhC334PxGrHuDsDW/uAldhXoK3ijDON+j1qHEEE6YycHpgfLDUms38JodE+GQJbNlKKXulgDlbul2jOt6YOUTXS0f9qfEUFhCfgzj7vP6mCU2qCO/odB5mJiB+Hrc2+xu7gHdkAzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 19:13:24 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7339.022; Fri, 1 Mar 2024
 19:13:24 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>
Subject: Re: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Topic: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Index: AQHaZTRaOJgLUchwQE6XetZW57kOZrEjSxYAgAADkIA=
Date: Fri, 1 Mar 2024 19:13:23 +0000
Message-ID: <78da25c9160612bc60bb1b421a0226e4368db51a.camel@intel.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
	 <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
	 <SN6PR02MB4157B2E6EC690B11AB334522D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157B2E6EC690B11AB334522D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV3PR11MB8601:EE_
x-ms-office365-filtering-correlation-id: 0dcb1151-d393-4aab-8176-08dc3a23aa93
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/9eVNNJQgrBUesbskFkDn+X0lJJgfQJyEPrOdI2Wv4aZzlpeBYJCvbDrSzsOJcjYDAoPSv6OKpoeJcgjfDFKYT4UP11Bko5w3zdy1aziTj/PbVvle9eKXq4WvuJ/cJbbHBaM3Ct8yl6FTF9C9TFGtGkjAcKk/c1QYGl+PCL/rNhZVKZ2BGmLBpA3fx3RvwDyh/plGojYL0uz9qzEjZbD98LnDmuxCyIv37n39QMGjM1yUX22Ux8VXOPyZekfGSa/cRf/tkcP4YZxS4ZSKJhaPhXOAaMr+ZleNIiJOzw+DFhYTsehXKkKZTvjhNFgAZ/cIRQ/QXXmQ6q+MKyD/0t+gEYKIWlN/A7rFxO2m52WvgygAJGkVn2GQK0oQJ9JqVqO0YdgzW5pRAmeTDzs7pIMAGqbdIfUNy21U6vmkWofGaaGN3TWszNs4XJp6ddR55hAHbqdexxitfRoOkaVgOR9kgmBNSBbU+c88YS4RURDD8mfwF1YnBNP9IIv8fyUv4PyRmSjsI7A7Hdbf74FAZNLDf8MVk6osF7UKTIjNJQXSAnLoCni/QyxRlRJw3XuJMofKKzsa9NwqCwUA1rgdNW0tUFQBy3UBO46btx3JSMt8itgNIjJwevYvIM0zui5SC2GWxnq62pzcgmF1wCnCBAh75mO1rUoGaY55lj4ghiIubJWsT96l+XLjQ8WzrfuxNmvP6zsuZXuJ/lL8jwt2NfZ5L65C1BRXAQNRzmkm+6Q9U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFPVnZjQ2dCcTBLanA5VUdLSVdHRjQyV1FUczNFZWpiZDF5U2NiRitZNW1F?=
 =?utf-8?B?NWNtTjFhNHVtZEJhUGN1ZHppbytaYWkyRmhrTlNlUmdWVUlEVEZERzB2ZnhW?=
 =?utf-8?B?Sitnck5aTXVNbjRwTHdNK2ZtVzNCRE92UHVwN0RYYWt5TlVtNVNLL05kU014?=
 =?utf-8?B?VlpvTXZNZjBwSWloR0Z0NW9QSFJOelk0aEZzbEh2SGxpek42dGp5SWR3QW9F?=
 =?utf-8?B?M0VsN2hRZjBzU2taMFZTanpkdVdVWUVuMUVaWkVJVENleVFwQkxKK2ZuMk45?=
 =?utf-8?B?UGQxcXBWZXRwUXdwZDhSdmNBVEdFbllUNmR4VnNJUHJhK0dzR1prWWpJVEdy?=
 =?utf-8?B?ZVFrVFo3RDVoeGF0WXlBTGdMOEtiNzNUZzVMY2VOTlV3bG5lZTdnOHVNWmx4?=
 =?utf-8?B?V2RuNlczaDF6MXNFaUUzazV4cjg5bUl4d0hXbUU1NTdrOCs5bEtwRWxWZUN3?=
 =?utf-8?B?eXZ0ZEFscmpJWk5naXpSaGVNYTJWQzhtZGhjSTFYbVgrWTU5MWV1Q25FaE1P?=
 =?utf-8?B?UGsweUR6QTBtNGlydGQxTnhMWGFJdjJNdU93aHdHQkRpVTlGTFY5TFYzbmkw?=
 =?utf-8?B?cG9xRG84S0E3Zi9SUFRYK2syUFZtQzRVaXkrZUREdGFySzNFUmlhaVhZbHlG?=
 =?utf-8?B?ZG85VXpDdWlSbGlvb3EzVkJ2SEpYeTJiQU5SeU1vY3E0QStNeWZzRUs4WGtw?=
 =?utf-8?B?YjljQjRBTGVJbFo2U0dhMU1uOWJLQ1RMVnNCUWd6UW9iNU90aWs5a0xGanBG?=
 =?utf-8?B?TWFVVW1GVEw4TFZVNjVSSWNUeGtYQWlybFFLUjljSW1YUHI5NTlraSs3dE1W?=
 =?utf-8?B?d040TVliUGJSdCthNHpPRzVWbHlOU3RXREY2SWhXbEE2cHRtd0FTL0JnQnlQ?=
 =?utf-8?B?MGtjY1JKWlFzbmpXZGNCRmRBWFFiL3Z3ait6ZVNjeDAxVmo5QlVKdUtpMjVF?=
 =?utf-8?B?bkt2Wk1ScWsxSFJRYTRHV3RadGQ0OVd5UXZreDdycTRGeTFKWURqK0hoY2Ux?=
 =?utf-8?B?QW9OQWczQTFwY2xJYmJSUG14QnpHbU4ramlTL2JzTHVwbXpjdlMzSldRSHY0?=
 =?utf-8?B?Qmo5eU5SVW1UM1NSZHZFTFQ3TDVvS1RQalhleGdtU0pscS9VamxPb1RqS2px?=
 =?utf-8?B?L0srWmRiY2ZaeXhMWS9UQ1pDT0QwLzBrUHcwUWVNWmRkS0pvTUJJRkUwajhB?=
 =?utf-8?B?SlRoOUNGMHVXbDVlQkpudTcrcG9RZFZDeERvTWdrd1NKRThsSEE0QUlBcTV0?=
 =?utf-8?B?OExHYTVaYzMwWWYwZzRtckVPV2xmb1J0N0lnQ3dsOXRkNzk3Y0ZJKy8zc0ZV?=
 =?utf-8?B?S05TWUJVU0tlUEVPdWtJU21oWHJqaUcvUUE3K2RLYTlTOGRpOXdPT0dTQ3pX?=
 =?utf-8?B?OGRqOGpYUUZCZUpBWVNrbHNWeUsvWmUvTjE5VmxjSzM0bW1PazZYamt5SlFW?=
 =?utf-8?B?L1N4Wk02cE0wdzlFTDVqYTR1MW5RRGJIUkNlMFM4MDBQdWRsU2Q5WEZoamRW?=
 =?utf-8?B?UGtoNHh5eTd6U0tjYk5HbW5hcm16WnFZK2hLSnJuL0o2Wk9DYUFURmRuRlVz?=
 =?utf-8?B?S3JiMWRGRVU0ZTBNRXBYVEJoQlZPVml1bG53cmVYYVI1Z3NZVWtDS3llL214?=
 =?utf-8?B?VDBPSCtmN21Ed2h6b0Q2WnYvc1FBblM2VXk0WDU1TFhiQ05FZnhaQ1dSWGtG?=
 =?utf-8?B?WE0wRXJpWllWUUY0U0JIWFdQcWlMK3JXOThvSVdkNFdTZmN0RjRhN1pxQ0o1?=
 =?utf-8?B?VkJzQWl6Y0FuWGtWdTRzT2FSOFJDeWp2R085ZEU3d0lxZUtWMnFKbCs2bTJX?=
 =?utf-8?B?WHlvcnlXWkNZcTM5dDR5UUhJUHUvZnp2ZUpHZVhrK1hyYVBMd05IK29yQjAv?=
 =?utf-8?B?dHBOaDBLUHlGSzFIQzBBTVhCb0Q5dSszRlFGcWRIRkRlaURBR2ZKbXA4SlZu?=
 =?utf-8?B?YXNSOGZrRTdUMi9PVms5M1VSc3FOTmp5MkVSUk42NEFjbjNPa2lhclVvTk05?=
 =?utf-8?B?emJ5S1E5NUVMZ3RWNHZEWVlpWlhDY0I1blQ0dHNwbDRXUmVRSUNjbSsrWS8r?=
 =?utf-8?B?ODJmU2lIdllNdTNRcDc1UGc2SHNxZGgwZWFnSG9kTHdwdUsxRnM0M0h1VlNI?=
 =?utf-8?B?dUZUcmtwZ0Z3dVJsR0orQmxkVENoSVJMNHhCZzdJRFN5dE1KOUVNZ24rYzlG?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8A8DFD937B91642AEFD389DB4CD8C6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb1151-d393-4aab-8176-08dc3a23aa93
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:13:23.9662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmUwASRRAfSq4M6AhtKkDJPyTozS448IrUZzt7KZMB6TmJBK0oKvt7d2U6FgFss1ypHhhAsQzqUBN3HoJ+5UnNx/ALNnje+iwIt15uLSaTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDE5OjAwICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gRnJvbTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBXZWRuZXNkYXksDQo+IEZlYnJ1YXJ5IDIxLCAyMDI0IDY6MTAgUE0NCj4gPiANCj4gDQo+IEhp
c3RvcmljYWxseSwgdGhlIHByZWZlcnJlZCBTdWJqZWN0IHByZWZpeCBmb3IgY2hhbmdlcyB0bw0K
PiBjb25uZWN0aW9uLmMgaGFzDQo+IGJlZW4gIkRyaXZlcnM6IGh2OiB2bWJ1czoiLCBub3QganVz
dCAiaHY6Ii7CoCBTb21ldGltZXMgdGhhdA0KPiBwcmVmZXJlbmNlDQo+IGlzbid0IGZvbGxvd2Vk
LCBidXQgbW9zdCBvZiB0aGUgdGltZSBpdCBpcy4NCg0KT2ssIEkgY2FuIHVwZGF0ZSBpdC4NCg0K
PiANCj4gPiBPbiBURFggaXQgaXMgcG9zc2libGUgZm9yIHRoZSB1bnRydXN0ZWQgaG9zdCB0byBj
YXVzZQ0KPiANCj4gSSdkIGFyZ3VlIHRoYXQgdGhpcyBpcyBmb3IgQ29DbyBWTXMgaW4gZ2VuZXJh
bCwgbm90IGp1c3QgVERYLsKgIEkNCj4gZG9uJ3Qga25vdw0KPiBhbGwgdGhlIGZhaWx1cmUgbW9k
ZXMgZm9yIFNFVi1TTlAsIGJ1dCB0aGUgY29kZSBwYXRocyB5b3UgYXJlDQo+IGNoYW5naW5nDQo+
IGFyZSBydW4gaW4gYm90aCBURFggYW5kIFNFVi1TTlAgQ29DbyBWTXMuDQoNCk9uIFNFVi1TTlAg
dGhlIGhvc3QgY2FuIGNhdXNlIHRoZSBjYWxsIHRvIGZhaWwgdG9vIHdhcyBteQ0KdW5kZXJzdGFu
ZGluZy4gQnV0IGluIExpbnV4LCB0aGF0IHNpZGUgcGFuaWNzIGFuZCBuZXZlciBnZXRzIHRvIHRo
ZQ0KcG9pbnQgb2YgYmVpbmcgYWJsZSB0byBmcmVlIHRoZSBzaGFyZWQgbWVtb3J5LiBTbyBpdCdz
IG5vdCBURFgNCmFyY2hpdGVjdHVyZSBzcGVjaWZpYywgaXQncyBqdXN0IGhvdyBMaW51eCBoYW5k
bGVzIGl0IG9uIHRoZSBkaWZmZXJlbnQNCnNpZHMuIEZvciBURFggdGhlIHN1Z2dlc3Rpb24gd2Fz
IHRvIGF2b2lkIHBhbmljaW5nIGJlY2F1c2UgaXQgaXMNCnBvc3NpYmxlIHRvIGhhbmRsZSBpbiBT
VywgYXMgTGludXggdXN1YWxseSB0cmllcyBpdCdzIGJlc3QgdG8gZG8uDQoNCj4gDQo+ID4gc2V0
X21lbW9yeV9lbmNyeXB0ZWQoKSBvciBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHRvIGZhaWwgc3Vj
aCB0aGF0DQo+ID4gYW4NCj4gPiBlcnJvciBpcyByZXR1cm5lZCBhbmQgdGhlIHJlc3VsdGluZyBt
ZW1vcnkgaXMgc2hhcmVkLiBDYWxsZXJzIG5lZWQNCj4gPiB0byB0YWtlDQo+ID4gY2FyZSB0byBo
YW5kbGUgdGhlc2UgZXJyb3JzIHRvIGF2b2lkIHJldHVybmluZyBkZWNyeXB0ZWQgKHNoYXJlZCkN
Cj4gPiBtZW1vcnkgdG8NCj4gPiB0aGUgcGFnZSBhbGxvY2F0b3IsIHdoaWNoIGNvdWxkIGxlYWQg
dG8gZnVuY3Rpb25hbCBvciBzZWN1cml0eQ0KPiA+IGlzc3Vlcy4NCj4gPiANCj4gPiBIeXBlcnYg
Y291bGQgZnJlZSBkZWNyeXB0ZWQvc2hhcmVkIHBhZ2VzIGlmIHNldF9tZW1vcnlfZW5jcnlwdGVk
KCkNCj4gPiBmYWlscy4NCj4gDQo+IEl0J3Mgbm90IEh5cGVyLVYgZG9pbmcgdGhlIGZyZWVpbmcu
wqAgTWF5YmUgc2F5ICJWTUJ1cyBjb2RlIGNvdWxkDQo+IGZyZWUgLi4uLiINCg0KT2suDQoNCg==

