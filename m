Return-Path: <linux-hyperv+bounces-11960-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s907DbsSVWq6jgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11960-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:30:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36A74D9F6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jWfFgQv2;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11960-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11960-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33AA4300DEE0
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264EB335067;
	Mon, 13 Jul 2026 16:30:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5333B6F1;
	Mon, 13 Jul 2026 16:30:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960248; cv=fail; b=NcDE/lWG+ApjfeguOFZta3XI9bu5dCFOQJDu1IrDTyDSCrJkXy4gcT3UbnyGPsLUiIeA5YVfrv6LupjjkSk5LBUe8Ms/uLiphoQ9BYCYplM6vGd08RjSI9CQfy+FQG9AMkFWMiDPB38C3IA/SyX9Yt98fqRbWGVHT4tFDkebFDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960248; c=relaxed/simple;
	bh=+iM7UMlTI5Awm5KGCZHGksDQhUXyXkHsyWUwQTroEf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dD4Bs1Ze2XfOQeJa1SnFXdDZT7Vji54ZTD8ZC81U4Sh7o3Vg8c6VmCnMhZfiSjbfUrtLpMrELZeTuzw4JyLsc3ge1kGxcmT3XPm/+cgXIQ/iQCUHd7LwjJM+8GOcBAGzmCCbX+Xeeq9Qvwao2Y/bO/bxa0OV33Ta+qjnZAg+x4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWfFgQv2; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783960246; x=1815496246;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+iM7UMlTI5Awm5KGCZHGksDQhUXyXkHsyWUwQTroEf0=;
  b=jWfFgQv2h0A/RYP1Z+v723Apj8FH32RLGw/Tj7yElAFtFKCAuNxVLoMu
   pJXd0rwEHnedLQYjsykGDDtwU2HptwXIvDyg3MJUP/i5dwMsRI81hr4Lr
   O91PwJKPFa5lSp65DOQdR9+Ua0w95w5XI7mCR1omphx3KbypH2iQDvkJS
   AM52b8F61xHKFKKGBIc3S9h39gFvIIrZ7v2OcLkrco19uz1eXg/quJ4YH
   fMqHBOWhozTjIB436rJMVZnTf1zQtsCPYUKNFB/xrK/JnRF2Wk3+/PxsK
   3kUAFcQQF8m6if2ixvjHeJgOTh2Hdg1bmyp70o+LAq1+csdfEKcvdpPui
   Q==;
X-CSE-ConnectionGUID: 69bybwjgTzmEqZ130YD88g==
X-CSE-MsgGUID: Vq17zDJwRKCUSLpLb6eB5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84430195"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84430195"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:30:45 -0700
X-CSE-ConnectionGUID: Q9j7w+qrTO28zp7CylLXDw==
X-CSE-MsgGUID: MXcEJyz4T/2oo2OJ9YDiuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="280011461"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:30:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 09:30:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 09:30:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 09:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO+Df+r51vSGgJY4q24+uharpanMnAallz2mI3Wv9zfG5PtxO60Bt8csozdhkeaoDqyqcA2bYPTDm8kh1lPmCrAfKswqdgrMh6NbNGWsH2KKM41xkcVMUsOPpxwkQzuGgAKl0/67xL+CwJwxc2fZAEWwjZR6g0fSYx9vYjaul9ourHKj6LIDegLgIxAXT6M7nn3UnQtXpniIak5Oi0ojCxbahht9qBdhejfvYX043jxmK8IThuhX+mA9bSXTSDf7BI6pialtvhX3Tj7IkJfbsDzoF/d1dRg6x/heHBiA7dHl5vX9NobCowNEEdT2p6n1nrmNKC1Zj8lI2vVWsMjPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shJFAyHrud5YcV5uquL8TTVZ94XzsbEgXibQPpr2JOQ=;
 b=KiHV29us3ehwfKhFbqTR4jLDuqIRcBb1zdwKy2NrLh6jsYNcT22vlPjreBKR8HrtxSZUOUPAVYd7r7q2Kdqw/Lxjv2LCk7HQcc3Yxzh8ZBkPWKc7iQSB4OM5ynTjLzFk2Wn80ppvNmb2FzQOX8Mv/FllXmSzwzQY6KxG5A3kh5JobhiZbkVfPv7zrOYOa3EVKcIFPJZg5QaQRaTz8y7DpDu0eum3/+KXnanhEaqU8URb3CoaGpvFgneiaDQqlLm5b1sxD1xVS8tT2s9u1RTpjFGtvINDU2rLYlQLk1dEfHuwdzLE9VJpRx7lU314RbVe/09B3kvhg5QI+NG6VEZ8Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:30:40 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:30:40 +0000
Date: Mon, 13 Jul 2026 09:30:35 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
CC: <airlied@gmail.com>, <akhilesh@ee.iitb.ac.in>,
	<akpm@linux-foundation.org>, <corbet@lwn.net>, <dakr@kernel.org>,
	<david@kernel.org>, <decui@microsoft.com>, <haiyangz@microsoft.com>,
	<jgg@ziepe.ca>, <kees@kernel.org>, <kys@microsoft.com>, <leon@kernel.org>,
	<liam@infradead.org>, <lizhi.hou@amd.com>, <ljs@kernel.org>,
	<longli@microsoft.com>, <lyude@redhat.com>,
	<maarten.lankhorst@linux.intel.com>, <mamin506@gmail.com>, <mhocko@suse.com>,
	<mripard@kernel.org>, <nouveau@lists.freedesktop.org>, <ogabbay@kernel.org>,
	<oleg@redhat.com>, <rppt@kernel.org>, <shuah@kernel.org>, <simona@ffwll.ch>,
	<skhan@linuxfoundation.org>, <surenb@google.com>, <tzimmermann@suse.de>,
	<vbabka@kernel.org>, <wei.liu@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v8 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Message-ID: <alUSq0o7CC2Pnr+H@gsse-cloud1.jf.intel.com>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371883977.900500.2198446134676328631.stgit@skinsburskii>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178371883977.900500.2198446134676328631.stgit@skinsburskii>
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 038359bf-0ffe-445b-af99-08dee0fc1388
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Uy1x/Y56yo0/5EKDU1d1nqG2fXHZ0QxWg6ItuwcJWEZMCPGFdxzVq4IVduoQ43AyvoEOXSf0MAcFVyehjDfhkCX0i7su/IPvsXyoiHoQZqQ8Dv2HP8AEikASNYLZS+IuysMzzEby6H35hsrYGzZLxH+b8fAOBaN8VtmfSXIA6G1UokKRJ4rzfBOpOvr1dw4ywMjWl+i08Z89lVK1z0pfygG/OyHAKRFGOoUvyGmmxyEd8zxEhs0R8SB9NuGcKp9f5i4obyAPiH9u8WtVWATwiDNkrBwI+zXe3P8IuMu7Z9XoKKaNxeDIHll/QX9KEiK8xALVEGWp2ell5clgbouxHPpS0+ycPFLOF/nqM5StqsL60slg18SnrJW6BRm3ht28ANMjSeYSo97dcbKxl8eMrqC0mUMPRlieyOUGiWtdASg9JNBjHSn9GzJhDLNWA+6wqL13Mh/Aqe2mkEWJiCd/tm8c/QZkNvR/jO1b766NF2WVIrlOw1+ubQcf/durbzxLQWlF18fUwvH1j7Mt7Tf3uTDcLhh7YaDZzgg5zrUkmdGdS7ChUbxAQEnuIR0sUqUjuq/zsmNaWzQKom+tBJ06fWfIxcBVku67npUvTgbFYe6nnYlmt2PK7pRzk3mfraIavKfx33wP3+/HKfJLkx7dsT58fS7ierfERQMCOaQcVxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i35I8h1Qg41m/1i0+vp/K+Ws0I4HcXNsWMXEyeFo6j+ErcwN0vF89z7MxUJO?=
 =?us-ascii?Q?TfrEy1OS6JEn/HioGZBFBHqMvUpvftIHdDiwUwYTV8gF9b+PKGfNT9EofcIF?=
 =?us-ascii?Q?kxAr+JW68gMrgQmIG7HGYwrZtoFOxmxdXddl52+WqInjBuYKtuSVn+xrhh6w?=
 =?us-ascii?Q?ofmp/i+zvbrO5mMH8TbO5lA/XclWWPhlvRpDyywFuaR+h7HwimenEK/D4r2J?=
 =?us-ascii?Q?SRzl2LfbTeWNRDpQ3FvBE7RIql/eo0ErFk6cNc+ust6Agl71ywqyJ8AjQVSJ?=
 =?us-ascii?Q?GFNh7foo9S5O6TW/LDRUbbJPdkK12+mgZhYC2JvHVfZfuaOarttpXlX9pAs2?=
 =?us-ascii?Q?ZY0RbdAJzuD9/zud/bepmkd2hqWGAqKcfSJqTLStvlNFxZzZEWeQ4pja8BAo?=
 =?us-ascii?Q?KBJ4uudo8rNms//io9vUACgyxAWNop61RknymYk+8rHpcJ8IuvSNN5T0Z+Qq?=
 =?us-ascii?Q?NOWMy1oe5MiNIf4vW4pSQggeqUhhnQ74AMRj7d4UMa8dfxvHMTlhIawvp6t8?=
 =?us-ascii?Q?FllhpTRohH/fP8ggN0VbLme0iut14hrCXuWQRSv+4MqAAK4RVkknbHfDwobo?=
 =?us-ascii?Q?ZbB2E9d3YSyhUfeU6EIelh9y7VVKLkYFL73qOpjG3LkgjSkTWCBfZ5xeebLi?=
 =?us-ascii?Q?rdjXqwQxrU+0Kx50KRPDX+Ic2muPtZX+70IgW1PeXxScdKKd22nE0RxH6tbE?=
 =?us-ascii?Q?ccvGnfi2tMMGCqimetFGFAYHnnIqiWUH7UNK14z4eHXbW7nrAUyuRJ/e2Dau?=
 =?us-ascii?Q?krf4cONY2ro48k3e+4KAgV10esntGIZK7YrKfUW0ndihJSECe8lScTpfMYs7?=
 =?us-ascii?Q?5QL3Ce8S05doBSHzVOyCbTsfcX71a76H+0LkSO3WiKbCSx27kgpsxGk2FFh4?=
 =?us-ascii?Q?6X3buTsP4ZcSHsditXTWXjRjJ/0peZJwQ0p07Rbr3SCIdPcbpKeKpLBCD2Zv?=
 =?us-ascii?Q?M4HUcgwcHL4iOk331/rTlkyYl53Lj0OgM7WXXrYNKL5TUdmvEYmYEXnwxchg?=
 =?us-ascii?Q?YA+jQnptLkAm2bTb40fXKDZPD/TjejuZnk6j0LrsilzT0xK6xCRaP/rCLIMC?=
 =?us-ascii?Q?Ugt3jdORZKcHh5Kkc+raIpySlobyBJC+spPx8stKH5WprR41XpdxtQnIn3P8?=
 =?us-ascii?Q?XjTwnInZjmp11425f6WoOnN5XDuXOMnHiuHBVZ10ps6eUmOkH9Tp+eJc02js?=
 =?us-ascii?Q?XS69z9Qah0onHgzrz3hDooM3ohrBxwqoWZ7F0zK4pVJ6NZ1FKX4k6J47Fi3k?=
 =?us-ascii?Q?0TbNI7QzwU+zR68mhTg4iskc6DAz2O+Mkkhsph0IbOgPVpnAuNrZjw3Br/4G?=
 =?us-ascii?Q?qW4JpJ7skduIky6+IyaggiX8k9f2KZaAdE33Lg1rdngaAMzr5WjjHYjpgE7q?=
 =?us-ascii?Q?SNupJpp8Gt4mFJp3Ey39m0I83Bffw934wPJhgPyz6ate9+aub8ag+I/0Gt+o?=
 =?us-ascii?Q?sL1d18Ctv7dN0+jGMwVx6CQigMJJ6xLmL+rhCEerZv/q3dwvSYbfIwG1p9R2?=
 =?us-ascii?Q?ckZe1xvps6VZdexAYiiiTE2ROsZhB2XwF4iaXOQF89ZfatOqLED2zAm7fwdb?=
 =?us-ascii?Q?CuFmgwpL+8qGaEoimLEpYnk/huUgRlojFELYMCNs+bbHslcQUH45PsQnX70y?=
 =?us-ascii?Q?Z1cMiwmWGmULvi4pz2yFdwMVfwCnXsLoRPAEsLMDR8yuNQ4FHHoiHyRLVZae?=
 =?us-ascii?Q?GFBYFLNY6D351FPQrgLPoyvjLLUtTEIR7Wf62GeS17rEC8cADr5RfiKfC19L?=
 =?us-ascii?Q?7oeKnjo1Ew=3D=3D?=
X-Exchange-RoutingPolicyChecked: Uz3sd0ycUUqWQ5KTeaItux2tw84wrnYOP/bPowPxlfT6bc/PeHAaQiNH4SatJw6zGNjbWxRnP5sD5JjkASnq7ZMGn/4YlbOnQYuGzic2xwaJZ73QxlElHrcDQBw8eAaZjL9SgTgFJ3rLUvjdmcOoChpa0KJklBkDflFuClCRUoCNB7RnhiFzkmQ7SvDPPF+w8QBcWMHRJ4YVSLJ02I/bEYNvDvdqySeTHOyFIIUIKnF/Wp0fLaOLMOSSzKX+CQEOwaYg82YvkfeZzSg8ovKmw/Wfty+H2Psxbf+dXGJUkjHBurstLpZj+xGLusUaHP1JVgBzVFMsrRsTRvrW7Pd2lg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 038359bf-0ffe-445b-af99-08dee0fc1388
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:30:40.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIzXeIH+EO/jPACPKgGCD2jncJwlH1gYdiRQ0zxBrmUz9WUoPq6pex720qNzBuYNYpO3uOuOpkf1T8bNrQpbpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11960-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim];
	FORGED_SENDER(0.00)[matthew.brost@intel.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB36A74D9F6

On Fri, Jul 10, 2026 at 02:27:19PM -0700, Stanislav Kinsburskii wrote:

Please send series like this to intel-xe@lists.freedesktop.org list too
as this will trigger our CI which expercises the change paths changed in
this series.

> Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault(),
> then retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires. Those paths use
> MMU interval notifiers whose mm matches the mm that was locked for the HMM
> fault.
> 
> Use hmm_range_fault_unlocked_timeout() for those faults and pass the
> remaining retry budget to HMM. The helper owns mmap_lock acquisition and
> refreshes range->notifier_seq internally for each retry, while GPU SVM
> keeps its existing driver-lock validation with mmu_interval_read_retry()
> after a successful fault.
> 
> Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
> called with the mmap lock already held by its caller.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c |   52 ++++++------------------------------------
>  1 file changed, 7 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd..6b7a6eaebcd9 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -788,22 +788,8 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
>  	hmm_range.hmm_pfns = pfns;
>  
>  retry:
> -	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> -	mmap_read_lock(range->gpusvm->mm);
> -
> -	while (true) {
> -		err = hmm_range_fault(&hmm_range);
> -		if (err == -EBUSY) {
> -			if (time_after(jiffies, timeout))
> -				break;
> -
> -			hmm_range.notifier_seq =
> -				mmu_interval_read_begin(notifier);
> -			continue;
> -		}
> -		break;
> -	}
> -	mmap_read_unlock(range->gpusvm->mm);
> +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> +					       max(timeout - jiffies, 1L));
>  	if (err)
>  		goto err_free;
>  
> @@ -1439,21 +1425,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	}
>  
>  	hmm_range.hmm_pfns = pfns;
> -	while (true) {
> -		mmap_read_lock(mm);
> -		err = hmm_range_fault(&hmm_range);
> -		mmap_read_unlock(mm);
> -
> -		if (err == -EBUSY) {
> -			if (time_after(jiffies, timeout))
> -				break;
> -
> -			hmm_range.notifier_seq =
> -				mmu_interval_read_begin(notifier);
> -			continue;
> -		}
> -		break;
> -	}
> +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> +				max_t(long, timeout - jiffies, 1));

Unaligned indentation.

So I'd write this like this to avoid weird wraps:

ctimeout = max_t(long, timeout - jiffies, 1));
err = hmm_range_fault_unlocked_timeout(&hmm_range, ctimeout);

>  	mmput(mm);
>  	if (err)
>  		goto err_free;
> @@ -1736,24 +1709,13 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
>  		return -ENOMEM;
>  
>  	hmm_range.hmm_pfns = pfns;
> -	while (!time_after(jiffies, timeout)) {
> -		hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> -		if (time_after(jiffies, timeout)) {
> -			err = -ETIME;
> -			break;
> -		}
> -
> -		mmap_read_lock(mm);
> -		err = hmm_range_fault(&hmm_range);
> -		mmap_read_unlock(mm);
> -		if (err != -EBUSY)
> -			break;
> -	}
> +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> +				max_t(long, timeout - jiffies, 1));
>  

Same here.

Nits, aside LGTM.

Matt

>  	kvfree(pfns);
>  	mmput(mm);
>  
> -	return err;
> +	return err == -EBUSY ? -ETIME : err;
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_range_evict);
>  
> 
> 

