Return-Path: <linux-hyperv+bounces-4395-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00227A5C157
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 13:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B237A3A6BEB
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AD2566DF;
	Tue, 11 Mar 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROjDExmM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8462253F3B;
	Tue, 11 Mar 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696507; cv=fail; b=pd6r7T7CbUFSY+X9TzDil43rGLp9oSdOLVWLKyT9uwREfgu6KLobf8KEZ0OZDIgiQuIM76TBOyDsYxrFVzbXfBLRMXrtfC9WaqgSMnC4koSlUQJEHJkey4Wkg2PeV3BCbyOvFVo7rGh/sEYDinyeP7HFQzkiDfSVEtavH3oEMYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696507; c=relaxed/simple;
	bh=jWDpr6GnaLVAogYlj6asF/BBgBzBw1iv84ZjX6Fl+Bw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ya84fAi1HhyrhfPVZAidKO9rYkyMDhVTdpfKKmdTmLmw3X5yWZbY8Jq8lLsVb/kZNPkQ7ol4zT0mXrnyZrHqvDnB+6wZAO91h70TDowmY53KejzWCySTXeHwtQ2IG9ZevsuIzG0mYSESsUzHx+6Z2X//JeOvgq4k4ad2g1sDryk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROjDExmM; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741696506; x=1773232506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jWDpr6GnaLVAogYlj6asF/BBgBzBw1iv84ZjX6Fl+Bw=;
  b=ROjDExmMDlTb2xMUk/V0BeynCgJAh1IQoJXdCqNrZa/O1pF1t5HPsxiT
   k6BdfPaijVvOKJIGfC3yA1iRFLXP52ejnDVBxMuW1fg8C9LojZaroSChm
   4mNbmm9d8JVAy8m5BDCTjXZlNRxvg9n3O5rObS8hvsMgTMmw7E0P93M01
   uf3536mPl9y6548iNTogbE7E4OCSaEgQVv74hz4HWA1Qf7PESRs1pCpMy
   qoex7EoUPhP3rlbGbQhpKvJgyXINIBhLVB78mA+GICU/AOiiW0reyvuAF
   +DFgHuxaTb+59w+/+dJk5X/zUFy/x8gI3xzGXMrvvblWYdTeWgUpYsJB8
   A==;
X-CSE-ConnectionGUID: /kdqU1kgSh2I74LNoHdRlQ==
X-CSE-MsgGUID: NndegbmpQjyolLhpS11UFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60136070"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="60136070"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:35:05 -0700
X-CSE-ConnectionGUID: srzxTJi3QDSlMuyFQoR42Q==
X-CSE-MsgGUID: njwT969IQBSwMZ3o3P4niA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120536033"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:35:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 05:35:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 05:35:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 05:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDwlKgwj4h/Czp0N+yVzF3mPmuLZtmiAhtZta37LUhWc55Atr2kFSg3wsocQuAPW9iIqFiAo7d11nC6oz8rn+QFwOWucM98N4cwieWwIPSecQtGs/j5um2CGDBIA9FGXoMzAvp4w2ygUa+ngrU2oI6QyUphJbU6yYjrX0XzBsYha3/jGvnBzl3OMUwQ9L6h655it8yFWR7L0zGbA7IPSlfL4DHzxWQ0R20nWSJlPfvbcot5l4OxTIBJFYbzPlg+DkICbPS7B9svx1gKLimPaftyBlDWGHEdvByLxZKpzP4xtHRo3BJ2lBbq6mwskLpOqbyDqCkf/SZpAcmrezNopNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yh4IIwlGpUnhNOHYeSmfg22WrQTwA/igbj5UNp1HF0=;
 b=MZdOqknD1xY4EDwvgs68SQ/kId/H52uKkNYlwlBxEifiT1YK7UasaAKChTnNDiaiBznzm4Yvt5durl8v6wA56jK8NHcbCHZBzj8Nr1qh9Vx0tVQ749dq43zu9FiFTv6Tfuog8yWnFA/NqRjfsv78DUhqxYFMUwIEoITpf0LTSKiI9IkPnQiYdN31uCwP/Zo1lWzcAaduSLG32cCH94Vb7JQWluw0+W1vz13tJgG5JJ2wmnHVxZ9ntuFTr5Fx9CC+35rnjO3bC/NOKM8zie6jMYoBRB6A+oO0H4xsM3bzz8tCWIHgZbGzkdbJphq+fAzGwkqYtcwKfItdQv24ISdATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:34:28 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 12:34:28 +0000
Date: Tue, 11 Mar 2025 13:34:13 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>, Long Li
	<longli@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	Leon Romanovsky <leon@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, Maxim Levitsky <mlevitsk@redhat.com>,
	Yury Norov <yury.norov@gmail.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Paolo Abeni <pabeni@redhat.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Dexuan Cui <decui@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] net: mana: cleanup mana struct after debugfs_remove()
Message-ID: <Z9AtxSilgYceOJCy@localhost.localdomain>
References: <1741688260-28922-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741688260-28922-1-git-send-email-shradhagupta@linux.microsoft.com>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|IA0PR11MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e495d0-93a3-40ab-65a2-08dd60991061
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4LxvhqBlfIyjQuvNXDRMcB9aTZxg/A5R49P1Lmdv6dVLtsj7yEVlleXzyp54?=
 =?us-ascii?Q?TnOpC02MuQ9y2BIVW1rRpngMGVzE94g0DZ71515SM4xIJQQ6H+xumj1YXzy/?=
 =?us-ascii?Q?52AW0cV1YyR0WOSP3iQWOdvvYH/kXcK+aN0WYND16h+pWUf8lIuW4BwGQKuc?=
 =?us-ascii?Q?rjAIMYDs/ScqwuetISjWWrCr8faiWKk6MnDJE4qt650kftIB829jmjHrj0Eh?=
 =?us-ascii?Q?dDqQGOereHpC+GDm6qc9Lxc4gnWDscYOZbux2vEcSvApVpN8S2TqIhv3QMKI?=
 =?us-ascii?Q?nlVzbCEMjzos+8rel3U4JYfl3aA5Z03o3LPLPKC4jiOJ9/rDQqwTRXreo+QH?=
 =?us-ascii?Q?RObiaIGQmh7DpirzFdI2lp3oSON5XZG2A2qWtuvmKosrhm/RuBBEk9qgLOMb?=
 =?us-ascii?Q?uNMoRUn0c/3Mad4Z86sSljHP7oRKWaIZ/9GYfg5412N5Y0i9Kex0/O9oBDBB?=
 =?us-ascii?Q?vL1aKmpV9Rjf/dPp6EowNwuqqT4HG/JbeUy/UOUGRT+JyZ1nu8N0eSRy1+QK?=
 =?us-ascii?Q?W3lUiEh1uJiziBL4jDd46G+UTu/H6neCFWtmDuJb7RY9WnbA2k6FOMqqUa7D?=
 =?us-ascii?Q?p9irxXCqA/ZAibuFuNY1SUFeRMclu19fUQqErxVOWwSmFgeCVMC+HYPL0MlN?=
 =?us-ascii?Q?AE2QA8eymgq/Rafji8IbXjdvYcck2zFjGCb8rBfoHIRWrQOsjeaDu67J7QQS?=
 =?us-ascii?Q?2rAPYVp9+fe/YnQnL0O3dVF/zcTEh+FAV+qal5RlFEeBxJsTEIbK0VI5CcGa?=
 =?us-ascii?Q?W7eX3zsFr2o5VgmTx5o74OCEUcqhe866Tx0NA1MnVPjn4TuDCtQuWsHoORhD?=
 =?us-ascii?Q?QpG1GBW4s6iXplvibtX9IzYG4GGG4Lvc+LyDDuEHmiuDq349cCUQoxMebXiu?=
 =?us-ascii?Q?4S+bbTbhDp16gBCsI5lVd39RJGa6IxL5Z7jxnWTj1KE3YX1LAJTE1x3hZSPZ?=
 =?us-ascii?Q?EoikvsKhD7q0Z8udF/WxeVXogvpZ2Y2FF6j+YDUrJ7/AqQA0gyJ9UrMF1kDp?=
 =?us-ascii?Q?mZ5bVivXZd2TH0anOliCvUCBu2qtEHNtaWeeeEfeeKSd9hBEAZqsTmMJiIl7?=
 =?us-ascii?Q?VwXBoUzX+PXlyCiFy6vOPNpMnlb7+MggQUQOY+7kv6bOdh3vWhs0rJ8JxbmV?=
 =?us-ascii?Q?sxYvJQQz27XNLHp2xYQIjBo9lVt1TZ0tk8oFnYu2cceftFTv8TsBM8w6S/2j?=
 =?us-ascii?Q?KsTkYY3AqU9N65Fpo05Icx/HIQlfQC9DumTvyhGb/ciHlkrEXYPIgKIuUQ7l?=
 =?us-ascii?Q?BmQ5ep0++JyxdttP+/uQ12OLY1hH+UoVNxkClHAV9dsfjwtsB8jkG7NEBOWb?=
 =?us-ascii?Q?PFEO/x11HXpwMvADueLDQLg+6maCCWw4a1LuF4bqyQlEWForWhIP5ltrOOh4?=
 =?us-ascii?Q?f3mCp34OojZPWf+TyAtBp6h32wfp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8p+d7wJ7tVnKMZY/GBXnZb5ML0ZDMvGFAaM5XTdTs4RXnG7eahU6u0jp55R?=
 =?us-ascii?Q?4JuKukxZ5A+rOxq7oeTSjyDim+gV7CxI4+/domsQyk7P4wjpflm1aJgSHiFs?=
 =?us-ascii?Q?n4vwWfnhxBgWrcOtTvzJWPE0ZphXOdDp3uaoqz8G+V3NrqTARLwG+N7vvTJM?=
 =?us-ascii?Q?7s1HbKI2zEG+BNnzcWMcDayEKO3b6xPzcAgy95FWj+URxa3rCs/hn0yWHzDF?=
 =?us-ascii?Q?yPifp0OcNDHv4VF0bjmAGZk4Gl+TRKY/72wQyKyge0RL8jNx9jknCpqlm68u?=
 =?us-ascii?Q?yDWpQhceyyCYhixlOdvSTIuwLxevky/a6N16oaxAxlbiS5P5vDuOaUWC/YnD?=
 =?us-ascii?Q?GojIF7du+nIUxsPnXp/uzJukGGk/lkaCVDpfvLsO1ILG66UeJE57pzXV/Spv?=
 =?us-ascii?Q?Lh4U+Q9pM8rR9eSA0YcMZn4BNMQ4BIN5D3ZjX3zAsjK4BXDGS7aBkvuW51TZ?=
 =?us-ascii?Q?WAI9BTnHt5hFSpKWFxDzls8ED3sCP4X1pLkWD4fFF/9/Gt0IlM9edIAayzrR?=
 =?us-ascii?Q?EUySw123beT5mufHP29emHn3qCGCFqBUW9daCM/bQLD5Yo707WgaPknW4RFU?=
 =?us-ascii?Q?TCdqdKOYg/O8lp2BjQUy+op9p80L0xExT7LIAUyl4WbKEw5PUrE3XRVmD6GI?=
 =?us-ascii?Q?919YvdSC+/nXsUgwElftimNBEuM9CMRPNPNOIHo5RqgHbsKprvVxVqKlyo8i?=
 =?us-ascii?Q?VUo/sqsYWIEENAPFazFOqJGV0/jVywVn+uDSV+vE7acgM5SwY8chT6y2DL8t?=
 =?us-ascii?Q?6q/3R7D6k3Su7UYL0AphU9zk2QEZ6gev5QLauhyLRWY+upzUmWKo/ApllPe/?=
 =?us-ascii?Q?Qh/aq+pyd2+pWwjE+QySzsU/caTxWih6hRCdIv1kFVtXebd6yAsuY9YK0vIx?=
 =?us-ascii?Q?DDzANKbLl9we7Qco4tHs3/dy68UfYnQiPxcYhr47Bs/qLTFINIeXNwlJg0vE?=
 =?us-ascii?Q?BX5pCbMiUGYAbQbu8eQUX30taw7L9lH8d12+lHwe3Nx1iBbqTCYjOG50MUSU?=
 =?us-ascii?Q?Cqch3q69dd3rHvIJBYdDjdH0OxQ3EHSN8NaAo4Z6GKbMTmUCVfB16rRfmmqQ?=
 =?us-ascii?Q?5djqCWDrThPGH1KYQxEHsTxY7aX+2x9ZvI/lPc7psmauz7rZ3qZ91+8mtE8E?=
 =?us-ascii?Q?3cmz+mSoQNVb7NPl54QLdhHQmv+U4ibT/Gp0guhnxyr+QRF0vznT/mz9fUAF?=
 =?us-ascii?Q?7jTsmYlyxaQ+qtXyeyQrLa9L7pnZzvn6E/dXHt/yd5vIhypry0Xgc15a0Hc5?=
 =?us-ascii?Q?b4plIy1LRhi4Y2qYC9Jbv/xmA5FDPIN4p4WWUqTnj1EYGuG4ODb3qPuGV2jR?=
 =?us-ascii?Q?7DoUJqYWTDxjN2ggADGIQ+GH3u072lObeCWo2fcbmgEi7pPvh5MbTN5ciCTP?=
 =?us-ascii?Q?GoLJh3ksp+88N/31tHypJOSubroPb7PrQLK4oVwW1Au+vJ/Fb70412OzfzP0?=
 =?us-ascii?Q?CkrtW+1kA+OXXcFVOt9FfNtOcz/sWGqJqUT03X6PWtYVQwcIVJm6zyABR6CP?=
 =?us-ascii?Q?Gs6JY+vdsejfM0VlkQ3Lc9Qxbr9ZApXTbptDBelAwOTze+MwoemR1BSwRphL?=
 =?us-ascii?Q?jhgJwGgWdiS0rbo+KV3VNbIYaw+lIwhGR5TO2Wz7zVZWkN0iiUJBEAGYp66u?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e495d0-93a3-40ab-65a2-08dd60991061
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:34:28.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QPPIoxFRkuYFc568+mZGHige+RCdTlm8DP/ijcE0JcNcnadbC2cIq6mU7sbF9cahStZacgFBhSOxeECFtFTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 03:17:40AM -0700, Shradha Gupta wrote:
> When on a MANA VM hibernation is triggered, as part of hibernate_snapshot(),
> mana_gd_suspend() and mana_gd_resume() are called. If during this
> mana_gd_resume(), a failure occurs with HWC creation, mana_port_debugfs
> pointer does not get reinitialized and ends up pointing to older,
> cleaned-up dentry.
> Further in the hibernation path, as part of power_down(), mana_gd_shutdown()
> is triggered. This call, unaware of the failures in resume, tries to cleanup
> the already cleaned up  mana_port_debugfs value and hits the following bug:
> 
> [  191.359296] mana 7870:00:00.0: Shutdown was called
> [  191.359918] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [  191.360584] #PF: supervisor write access in kernel mode
> [  191.361125] #PF: error_code(0x0002) - not-present page
> [  191.361727] PGD 1080ea067 P4D 0
> [  191.362172] Oops: Oops: 0002 [#1] SMP NOPTI
> [  191.362606] CPU: 11 UID: 0 PID: 1674 Comm: bash Not tainted 6.14.0-rc5+ #2
> [  191.363292] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/21/2024
> [  191.364124] RIP: 0010:down_write+0x19/0x50
> [  191.364537] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 de cd ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 75 16 65 48 8b 05 88 24 4c 6a 48 89 43 08 48 8b 5d
> [  191.365867] RSP: 0000:ff45fbe0c1c037b8 EFLAGS: 00010246
> [  191.366350] RAX: 0000000000000000 RBX: 0000000000000098 RCX: ffffff8100000000
> [  191.366951] RDX: 0000000000000001 RSI: 0000000000000064 RDI: 0000000000000098
> [  191.367600] RBP: ff45fbe0c1c037c0 R08: 0000000000000000 R09: 0000000000000001
> [  191.368225] R10: ff45fbe0d2b01000 R11: 0000000000000008 R12: 0000000000000000
> [  191.368874] R13: 000000000000000b R14: ff43dc27509d67c0 R15: 0000000000000020
> [  191.369549] FS:  00007dbc5001e740(0000) GS:ff43dc663f380000(0000) knlGS:0000000000000000
> [  191.370213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  191.370830] CR2: 0000000000000098 CR3: 0000000168e8e002 CR4: 0000000000b73ef0
> [  191.371557] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  191.372192] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [  191.372906] Call Trace:
> [  191.373262]  <TASK>
> [  191.373621]  ? show_regs+0x64/0x70
> [  191.374040]  ? __die+0x24/0x70
> [  191.374468]  ? page_fault_oops+0x290/0x5b0
> [  191.374875]  ? do_user_addr_fault+0x448/0x800
> [  191.375357]  ? exc_page_fault+0x7a/0x160
> [  191.375971]  ? asm_exc_page_fault+0x27/0x30
> [  191.376416]  ? down_write+0x19/0x50
> [  191.376832]  ? down_write+0x12/0x50
> [  191.377232]  simple_recursive_removal+0x4a/0x2a0
> [  191.377679]  ? __pfx_remove_one+0x10/0x10
> [  191.378088]  debugfs_remove+0x44/0x70
> [  191.378530]  mana_detach+0x17c/0x4f0
> [  191.378950]  ? __flush_work+0x1e2/0x3b0
> [  191.379362]  ? __cond_resched+0x1a/0x50
> [  191.379787]  mana_remove+0xf2/0x1a0
> [  191.380193]  mana_gd_shutdown+0x3b/0x70
> [  191.380642]  pci_device_shutdown+0x3a/0x80
> [  191.381063]  device_shutdown+0x13e/0x230
> [  191.381480]  kernel_power_off+0x35/0x80
> [  191.381890]  hibernate+0x3c6/0x470
> [  191.382312]  state_store+0xcb/0xd0
> [  191.382734]  kobj_attr_store+0x12/0x30
> [  191.383211]  sysfs_kf_write+0x3e/0x50
> [  191.383640]  kernfs_fop_write_iter+0x140/0x1d0
> [  191.384106]  vfs_write+0x271/0x440
> [  191.384521]  ksys_write+0x72/0xf0
> [  191.384924]  __x64_sys_write+0x19/0x20
> [  191.385313]  x64_sys_call+0x2b0/0x20b0
> [  191.385736]  do_syscall_64+0x79/0x150
> [  191.386146]  ? __mod_memcg_lruvec_state+0xe7/0x240
> [  191.386676]  ? __lruvec_stat_mod_folio+0x79/0xb0
> [  191.387124]  ? __pfx_lru_add+0x10/0x10
> [  191.387515]  ? queued_spin_unlock+0x9/0x10
> [  191.387937]  ? do_anonymous_page+0x33c/0xa00
> [  191.388374]  ? __handle_mm_fault+0xcf3/0x1210
> [  191.388805]  ? __count_memcg_events+0xbe/0x180
> [  191.389235]  ? handle_mm_fault+0xae/0x300
> [  191.389588]  ? do_user_addr_fault+0x559/0x800
> [  191.390027]  ? irqentry_exit_to_user_mode+0x43/0x230
> [  191.390525]  ? irqentry_exit+0x1d/0x30
> [  191.390879]  ? exc_page_fault+0x86/0x160
> [  191.391235]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  191.391745] RIP: 0033:0x7dbc4ff1c574
> [  191.392111] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> [  191.393412] RSP: 002b:00007ffd95a23ab8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [  191.393990] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007dbc4ff1c574
> [  191.394594] RDX: 0000000000000005 RSI: 00005a6eeadb0ce0 RDI: 0000000000000001
> [  191.395215] RBP: 00007ffd95a23ae0 R08: 00007dbc50003b20 R09: 0000000000000000
> [  191.395805] R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000000005
> [  191.396404] R13: 00005a6eeadb0ce0 R14: 00007dbc500045c0 R15: 00007dbc50001ee0
> [  191.396987]  </TASK>
> 
> To fix this, we explicitly set such mana debugfs variables to NULL after
> debugfs_remove() is called.
> 
> Fixes: 6607c17c6c5e ("net: mana: Enable debugfs files for MANA device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 11 ++++++++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++----
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index c15a5ef4674e..f1966788c98e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1579,6 +1579,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 * adapter-MTU file and apc->mana_pci_debugfs folder.
>  	 */
>  	debugfs_remove_recursive(gc->mana_pci_debugfs);
> +	gc->mana_pci_debugfs = NULL;
>  	pci_iounmap(pdev, bar0_va);
>  free_gc:
>  	pci_set_drvdata(pdev, NULL);
> @@ -1601,6 +1602,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
>  
>  	debugfs_remove_recursive(gc->mana_pci_debugfs);
>  
> +	gc->mana_pci_debugfs = NULL;

nitpick: I think the newline between "debug_remove_recursive" and
"gc->mana_pci_debugfs = NULL" is redundant (here and in similar places).
Logically, both lines are the code responsible for "mana_pci_debugfs" cleaning.
However, I don't think there's a need for sending v2 just because of
that.

> +
>  	pci_iounmap(pdev, gc->bar0_va);
>  
>  	vfree(gc);
> @@ -1656,6 +1659,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  
>  	debugfs_remove_recursive(gc->mana_pci_debugfs);
>  
> +	gc->mana_pci_debugfs = NULL;
> +
>  	pci_disable_device(pdev);
>  }
>  
> @@ -1682,8 +1687,10 @@ static int __init mana_driver_init(void)
>  	mana_debugfs_root = debugfs_create_dir("mana", NULL);
>  
>  	err = pci_register_driver(&mana_driver);
> -	if (err)
> +	if (err) {
>  		debugfs_remove(mana_debugfs_root);
> +		mana_debugfs_root = NULL;
> +	}
>  
>  	return err;
>  }
> @@ -1693,6 +1700,8 @@ static void __exit mana_driver_exit(void)
>  	pci_unregister_driver(&mana_driver);
>  
>  	debugfs_remove(mana_debugfs_root);
> +
> +	mana_debugfs_root = NULL;
>  }
>  
>  module_init(mana_driver_init);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2d826077d38c..9a8171f099b6 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -748,12 +748,11 @@ static const struct net_device_ops mana_devops = {
>  static void mana_cleanup_port_context(struct mana_port_context *apc)
>  {
>  	/*
> -	 * at this point all dir/files under the vport directory
> -	 * are already cleaned up.
> -	 * We are sure the apc->mana_port_debugfs remove will not
> -	 * cause any freed memory access issues
> +	 * make sure subsequent cleanup attempts don't end up removing already
> +	 * cleaned dentry pointer
>  	 */
>  	debugfs_remove(apc->mana_port_debugfs);
> +	apc->mana_port_debugfs = NULL;
>  	kfree(apc->rxqs);
>  	apc->rxqs = NULL;
>  }
> @@ -1264,6 +1263,7 @@ static void mana_destroy_eq(struct mana_context *ac)
>  		return;
>  
>  	debugfs_remove_recursive(ac->mana_eqs_debugfs);
> +	ac->mana_eqs_debugfs = NULL;
>  
>  	for (i = 0; i < gc->max_num_queues; i++) {
>  		eq = ac->eqs[i].eq;
> @@ -1926,6 +1926,7 @@ static void mana_destroy_txq(struct mana_port_context *apc)
>  
>  	for (i = 0; i < apc->num_queues; i++) {
>  		debugfs_remove_recursive(apc->tx_qp[i].mana_tx_debugfs);
> +		apc->tx_qp[i].mana_tx_debugfs = NULL;
>  
>  		napi = &apc->tx_qp[i].tx_cq.napi;
>  		if (apc->tx_qp[i].txq.napi_initialized) {
> @@ -2113,6 +2114,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>  		return;
>  
>  	debugfs_remove_recursive(rxq->mana_rx_debugfs);
> +	rxq->mana_rx_debugfs = NULL;
>  
>  	napi = &rxq->rx_cq.napi;
>  
> -- 
> 2.34.1
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


