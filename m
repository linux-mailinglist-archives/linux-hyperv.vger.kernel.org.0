Return-Path: <linux-hyperv+bounces-6282-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023EB098EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 02:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F9E1C48625
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 00:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031429D05;
	Fri, 18 Jul 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InHbMJ/I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832E4C6E;
	Fri, 18 Jul 2025 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798215; cv=fail; b=mc4b34VeHi3AsPwu/P0qnY+E9uVu8TRb7jqC0OyVpnVYQlEKy8SogTXqC6lIbBljMPF4UwHw9cfctfgGHd5NWODQ53Wx+TJefHrPg98An0hz9JC27OxmTRiUa2FQDIhILssofNN2io1N9md1ifc5IhejhQVRjYpZmJJbpWwuz1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798215; c=relaxed/simple;
	bh=2EMtvfnrHdeGXpv3soTVMxHYGmls+ESL6GivAEH9lFU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=t0NEu9fUH8rfvaCdzkLHFme0lGvqi2Ny/1ZIRW1dDT83DTB+1EP/MZeDSWXoNSixWjEKt6wVABRrny1TkJav2yu6IQc774Dni7BUapJmgm2856WJkOpLF6fDECZK1bjUaHIBwnfWb5Fb/L7S9EMYvoHkHUkcAVz8ZMPRG6Wwu4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InHbMJ/I; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752798213; x=1784334213;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2EMtvfnrHdeGXpv3soTVMxHYGmls+ESL6GivAEH9lFU=;
  b=InHbMJ/IZMymk7H2ZlbPAqF1X2LNUeEoNo4ZgoXDjfx6O5XxFGF6wZjg
   +HYl7N+OqdgBQ88w13jPSelbsvl59YqhjxDAHeKSyissP6DunxfnE+r5D
   z3F6TpC7+lYXv5MPXi4S4nxdcwUB84ZlpYQtDuipyyNe61uwRQdPtHyMe
   L+4hA8LlcW3NJCmrxz/MuYtdyXDlCbLjGgPV+Skb/Eb1/Mq9TZbZOXQzo
   vXJDiEoItZAE0f3UUiMvGJOJNbtcdMiArgk2Fz4sP059B8l9sRQIYZYwF
   CzWZnj6vKRzwtGkrxz1nn/zGPW9IXyKjl2MPoM4PXMnr4j782VPsbPsCk
   w==;
X-CSE-ConnectionGUID: 3AHZMbuTR0Gn4W7A7ig25Q==
X-CSE-MsgGUID: wgux2S4PScK7DBVHJlq8pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="57702499"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="57702499"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:23:32 -0700
X-CSE-ConnectionGUID: BUKd7XthSuWBsuGhairD4w==
X-CSE-MsgGUID: CrUzx1CsQh+pQhpDNb/Ujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188910634"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:23:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 17:23:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 17:23:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 17:23:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXKkdl+3zTHOem+95+ODDox0HGznqRAGtNgYsFi/MpAvhmjce/eHY/bhU6t9KuUZY/CyHuKVW+JtizHalU3nbc5P8GpQDiqhh5NYr3/lpSilIwDzbzTnwTk+7BNZ9AXY9e3x9epa+nkpLGuhWmgt5iDPfir/xIgoaGehRM7RiUaAz4OkVm6WgCOp4qevsHDkfoM3EUX7lliNx2VZz3xWJVG/b9fh4SjkCGxj+qmH0ChmHCRvRxkssgL8OhSAhY+LPH/lYdAoeqsJuXrG5L/KQUBUxhntd6/boSOc0eoY11XNE/qZhm6OaoHZ+qwPw3kt3M3lPoDcT5f/wdnGNQ1NyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usRDiEKPlr8BBBezgUKEL8ppgoDWRlCXvpWTjJMa0So=;
 b=cecYBZvEoOB+tES5BxkSH1yOJnvAug3S/d5VTaQMgxuZNUXMhxj/Vy9S/vRGLKhmqXlMH/Lm3QkhSfgRzpVQCw/X7sKp5SSoW7ujRY9NvR8I17RPUD5F9mFgh/ijc02PlDWgJda8fTSY0TeIU17rKCw6cvr2/o8PKEc6dOEjDXVxZKKYnd85l0O3wnlrJP2BZR4Qd8xaTjdgnDos67JThe1W0iZtPjF87CQd8qdnsejsx7uHXkLVPDMpASLNBMhh0HN6kQ30TSfamR07USZCwfjayLxHxTB5GoGjHqYuCMSODPWI+vSZsjQ/uDwr2EPqT29BBCtGcrNH6gtnL8AvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 00:22:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 00:22:58 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 17 Jul 2025 17:22:56 -0700
To: Michael Kelley <mhklinux@outlook.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Message-ID: <687993e03bb4c_14c3561008c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <SN6PR02MB4157E31D8448CD9D81D518C5D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
 <20250716160835.680486-3-dan.j.williams@intel.com>
 <SN6PR02MB4157ADD06608EFE00B86A3F7D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <68795609847f7_137e6b100d8@dwillia2-xfh.jf.intel.com.notmuch>
 <SN6PR02MB4157E31D8448CD9D81D518C5D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: fd343771-bf06-4871-8541-08ddc5913fc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0prSGExd0QxbUZGbWtvYlB0V3huQWxNMXJDTGp3Y2IzeWhUc3ZSNGZXQy93?=
 =?utf-8?B?SVVHbGtHa0Q3UmRMQmhFRnNFcVpVSUQvWklSbElFOTZKN09vVnMyeGt6NGFB?=
 =?utf-8?B?bVVaaVBhYisvS0dCa1BJNk9oSEFxcjBNano5emEzUTlPQjlWUmNYZlVqcFRI?=
 =?utf-8?B?SXdXSXRIMXI4aXFDaWJkaE1OL0NSNEJoUFlGSjNQaWc3WVBQZjZ6VXp6UUpG?=
 =?utf-8?B?V3VFV2JvY2U1QmNlUlZNL2ZYS3dtVzZLUVltSTdpMXdPS3pqUmExWUJoUFFV?=
 =?utf-8?B?RVNqc1hRcFkzQzI5U1E3K3FBb1lONUhVek9Oa1VVemZDQUk4Z2pKRlg3dEt0?=
 =?utf-8?B?a3I5a3hCbC9Da1BKWFFGOHZkT0NCSkQzSnFkS2dyUGUrVkFhalhiakxZV25S?=
 =?utf-8?B?YlI2cVBaMFVBTWQyUnpVWXlpZHFueUxRbTVROHU5ZzI0TFRKeVdrRndxNEdx?=
 =?utf-8?B?Zzl1YVhzUS9POU93SWtjeWpEZTAvY2RpYjBHVDZUdXNQeEVldHVaNXFCcyt4?=
 =?utf-8?B?bnRCUHBKZGpjNGJRMlRkVTJlVmpaOUlOdytmaFVSZ25NSFFFUTVLTW82Smh6?=
 =?utf-8?B?MUM5QTZkWVpocTBoQjdEays1elNrcEZpTVNBQWl6cE0vTTZRcHc2MTNvVm4r?=
 =?utf-8?B?dGRpeHhCajB6d2FGaFRYWU4yZXFBMjFGeXdxY3lBaDJFYTZPM3Y0SGxJQmFv?=
 =?utf-8?B?T3IrcG1GS2Iyd2JyQ3N4V2Uwa2dPQ2g2WWc2VVpKOEhrY0hoTWE3NThpNnZN?=
 =?utf-8?B?VDlmc3lERG5aUHlVaElZYkVjbjBmSFlwZnMydzJOQU83MkNTNnZac3RCU3l0?=
 =?utf-8?B?SDZXNUlYellRZ3dodC8zNmwyS21pSjZXOHR0a2hOUmdLZU0wdWJEeEpxL0tS?=
 =?utf-8?B?SW42V0NnalJDYjc0RDhDYm5tVlU3Ui9YQldNamc0ajhGWnZvS0ZuUGtqN3Er?=
 =?utf-8?B?MjJpVXE2cXYvVFRZWGpNOGt1UXBXNGNsaXV1NEtOdlRSdWpMK0E2OXBXZTVI?=
 =?utf-8?B?TTBPQ3gvVUlUWGx2eTJ5RjAwZUFFcW5maWE4Skc4TVJma3BLdnBiOStVZ3VL?=
 =?utf-8?B?dzBZSWhhSnNOUDZmalIzYkFRdWlmZGRxRlcwSDJrT3U5QnJ3a1pxTUlBQ1ZV?=
 =?utf-8?B?L3Y3RmhwWFU0aXI5UUdaWGxaVEw0L2NGQ251VWlvUk9hazkrZ2NlOFl0QnJy?=
 =?utf-8?B?bEdOUXJyOXh2QlYrcEIxNkdXVTZTZ1JXckx2QUxDRGVkbVJWSFlCZlFVZkdL?=
 =?utf-8?B?aWMwVDNSSU9aMFJ3ZUpZcHptcjZWdmY4c0lIRWNreTZEZWx6NjZOMlV4NzBw?=
 =?utf-8?B?Rkp0SmVySnFrTTY3Unk1MEs0SUJYRW9YZ2JvYldBdW9DdWJGQUJtSzVibWVG?=
 =?utf-8?B?SklOUHRMR0FHenMwd0ZkQVBzMWhkNzVELzh3V2dCVURub0h0ZFNuU1pYZG9F?=
 =?utf-8?B?c0dRMit2TWhsQ29OTVUwT0x5ZHFjMisxYjZkRk9SR0hGeFBCZzE1aWxBUHlo?=
 =?utf-8?B?WCtlQkltZDkyOGtFOTBNNFRmV05Nb3hsd0VhbmNHYTdSZm1vUC96TzZHZ045?=
 =?utf-8?B?OFQycFdvWXYvcFo3MVlCZFFqNjg2aEdWNS9PSXlTYng1QkRORm5kQjk4Qldo?=
 =?utf-8?B?WEdWVm1IMmUyblRmMFErclE3dHJUYVlSaks2d0x2eTU5aWJXK1lXM0VMdnMy?=
 =?utf-8?B?Tkl4a3FlWkpMWDY3Z2xIZWZUK3hRbGZsaFYxVjROSkNxZWlCaSt4Mkh5RGR0?=
 =?utf-8?B?dm10THVWTXVjMUg2M1BMRDJQeC9YZy9Gb0NLYTlOdFJEV0kvakFzdElDaEhJ?=
 =?utf-8?Q?m2TGxec2ufLZ1nuRsssu/8M+akm7E5dogpJLs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2l4eTlOb3dYTDJMWDRHREFESCt4Y1NETDN0SXF0V0FjbGx3UWlFbGh1MHJZ?=
 =?utf-8?B?bkpBcS9DUlN3dFpIb01lZGZZazQ2VGZPcFg4Mm5qSHk0bFNkZm95QVdhTTBJ?=
 =?utf-8?B?TXUrck10eU96dDduRytsc0tRV2xNbnR2OFJFQTlhUHFzbVRYejUxK2x1M1l3?=
 =?utf-8?B?eElmU2lOMVFVeUg4YTNxNUVjK3ZDalJKV3FRQ3NPRWZCUExTVytCUHkzQU5a?=
 =?utf-8?B?ZWZLSkVvZTVKZ2p4bVJlUDN6TmdBK3ZxVDJmNFFsOVJPZXgzKzNibnpQK2lY?=
 =?utf-8?B?bGpOd3hJczFFV0lJZlpsbWtKWTdtR2p1Ry9WWkpCMkRZSitrZ3o0dnhYc3Az?=
 =?utf-8?B?VElpTFJwV3ZtbjRBSVplTzRIdmwyUzJBR25ac0hNYmRURjRNcnhTVjkvZlg3?=
 =?utf-8?B?cFEweWEwRW9oeFN1a1Q2NnBYaUJGQTQ5M0JwVzNwcXI5THRPQ09UTWhIUUdG?=
 =?utf-8?B?bXpHUGU0cjNFWnhLdUNMV0xvdU5MbGhlSitZN3RwMHZYdzhKQXRMVDNqV0F5?=
 =?utf-8?B?cmVMU3JVZ1A2S3NHOTdvOFQreUdCeGo0R3ZObHpNbVpmSlpiMU55RGpQcEgv?=
 =?utf-8?B?ckJ0SDhiaEVBeWl6aDZZZkRlNXp3TVZRT21BMmpuK2VCZXRBRzZiWlUzQTVH?=
 =?utf-8?B?ckdUUE9jK2NVSGllamJTaXBNZTlSaFNvRlk3dXdDK3dIKzladGJ2Y1ZsZkp2?=
 =?utf-8?B?eEJmNUlTU0I0bFVwSnZMV1MxbGxuL3luNkx5MmQ3WkMzSURxaGYxR0MxaElF?=
 =?utf-8?B?TENJWUNTMzMrMFJyclp6cjBvQVkrYmw2ZmR1YWhYa2crNCtBcUtVTktnVStT?=
 =?utf-8?B?RU1icTNRbEU5cFdBbmRML2tVWVNIeU45UUZnWGpOVVRsV3YyTlY1TW1uVXVN?=
 =?utf-8?B?MGJDRnluSmsveTZzUFo1cDNaVTFKWXlWam8yOXBTKzd1UFlQUDd0bFJvZXk4?=
 =?utf-8?B?dWtJOHFRUTFVSnlqcXR3SjdnM2VsSS9BSUM5NFBNVEt2WHJUeUZOV0RXZjJk?=
 =?utf-8?B?UGxRdVdENzRXTGQxZ1BOSEdNbU90VHowL0tNQVBPWWN4MmNWZmpkL0g3SGtY?=
 =?utf-8?B?WExlN0hSNUZLWklRdjBpSWVsWXhBbmlnVlk5a2MvTTBMbTdRNVV3UGl1Y1dR?=
 =?utf-8?B?ZXFWVkNpMUIyNFNEbVBEeG9wdXF6SzdlbDJSVnB1OEdFNGY2UlRmUXFsZDRl?=
 =?utf-8?B?bFFHM1lNLzhxeThHTWVtUHdDbEZsUGI5TlEyY1FuQzRQR1ptUW9HRjJrc0Fy?=
 =?utf-8?B?eUFTYk9GUXVwWnV3NmwyaHYrZzAwUmZBYzZ5Wkx4eHpSUnNvd3FZb2EvMmVn?=
 =?utf-8?B?YldiU1F3RjVQMjg5Nmp2bkQ4QzdLK1JHelEvWjhza25kYUMxbndncmVhREMv?=
 =?utf-8?B?RjBZUitzNXdkek5tamtyQjR1eW40OUFVZnFZbnZCd1IzSmE1NWZYWnV3aE16?=
 =?utf-8?B?eGxiYmtpSnk4M2lta3ZtQUM1UjBQSTYvRngzRGJSSkp0OFpmYmRCaWphQzY0?=
 =?utf-8?B?NCtFdDhMYW12SXd5RE56cG9xU25wNzFMVTBOaXU3N1Q4bDloQkx6R21xMml1?=
 =?utf-8?B?VDBKSVBGQTRyZGtNaWlORUs1T0k5VlpsTlN4RnIzMFhqY0dsUEk3MndjeGsv?=
 =?utf-8?B?WUwwM0JQYkxrRjNDdTYrRHJVVzZQT0NTVlcwTUN4MC9oR05UK29uWUpLU05E?=
 =?utf-8?B?dzVmNzc0QzZ5U1JqOU1oWWh4cy9WMFJIanhXZkhvYkFRNThaMUpxajdMVmFI?=
 =?utf-8?B?dmt4aFFaSzNQeC9wcVBjVW9CMFhlSi9oa254RmNLOXEyVmpaM01Bd3piM2JM?=
 =?utf-8?B?NE0xVHJyQllBL3VoSjJhSnlnQndzeDN0a1R6WkhzZm4xcjNRYk1ET21mUTFH?=
 =?utf-8?B?elNpakdmSlhWNk55QXNHaStlazUwcXh5NW9ydWZicHBhZnVQYXhVbXRZVGNU?=
 =?utf-8?B?a2xrNzcvZFVWcmxTK3lITVpqTWhEOHJtVlFJQnFzeGhEeGlaV0o1UWtCOHNO?=
 =?utf-8?B?N2dYTk5LbUtxQjgzSHVnYStrUU1KcHdHSGpweU9ra1VUSDRzWkZYak5ycXBO?=
 =?utf-8?B?alJoVUZwOXF0VTJhdUhXbUNUYTNCYldockc3MVM3cllXNWpXdmt6ZGFSdFVF?=
 =?utf-8?B?Q1kzaHk2a2IvRCtIMzhrTHBQL2I0eUVjMWdOSHlwNHhYVnFENEQvR0R2Y1Rk?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd343771-bf06-4871-8541-08ddc5913fc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 00:22:58.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uRksyD6Sh/0dmWOPujk73MkHwZITjB4QfZiJWV/DRqM5TxDs8SzwwzfSM4eY40hedhSmBVturxuqHrQ/uT4gZifQXoSEv9P/TW9x+nE3RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com

Michael Kelley wrote:
> From: dan.j.williams@intel.com <dan.j.williams@intel.com> Sent: Thursday, July 17, 2025 12:59 PM
> > 
> > Michael Kelley wrote:
> > > From: Dan Williams <dan.j.williams@intel.com> Sent: Wednesday, July 16, 2025 9:09 AM
> > 
> > Thanks for taking a look Michael!
> > 
> > [..]
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index e9448d55113b..833ebf2d5213 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -6692,9 +6692,50 @@ static void pci_no_domains(void)
> > > >  #endif
> > > >  }
> > > >
> > > > +#ifdef CONFIG_PCI_DOMAINS
> > > > +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> > > > +
> > > > +/*
> > > > + * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida or
> > > > + * fallback to the first free domain number above the last ACPI segment number.
> > > > + * Caller may have a specific domain number in mind, in which case try to
> > > > + * reserve it.
> > > > + *
> > > > + * Note that this allocation is freed by pci_release_host_bridge_dev().
> > > > + */
> > > > +int pci_bus_find_emul_domain_nr(int hint)
> > > > +{
> > > > +	if (hint >= 0) {
> > > > +		hint = ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> > > > +				       GFP_KERNEL);
> > >
> > > This almost preserves the existing functionality in pci-hyperv.c. But if the
> > > "hint" passed in is zero, current code in pci-hyperv.c treats that as a
> > > collision and allocates some other value. The special treatment of zero is
> > > necessary per the comment with the definition of HVPCI_DOM_INVALID.
> > >
> > > I don't have an opinion on whether the code here should treat a "hint"
> > > of zero as invalid, or whether that should be handled in pci-hyperv.c.
> > 
> > Oh, I see what you are saying. I made the "hint == 0" case start working
> > where previously it should have failed. I feel like that's probably best
> > handled in pci-hyperv.c with something like the following which also
> > fixes up a regression I caused with @dom being unsigned:
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index cfe9806bdbe4..813757db98d1 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3642,9 +3642,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  {
> >  	struct pci_host_bridge *bridge;
> >  	struct hv_pcibus_device *hbus;
> > -	u16 dom_req, dom;
> > +	int ret, dom = -EINVAL;
> > +	u16 dom_req;
> >  	char *name;
> > -	int ret;
> > 
> >  	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
> >  	if (!bridge)
> > @@ -3673,7 +3673,8 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	 * collisions) in the same VM.
> >  	 */
> >  	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> > -	dom = pci_bus_find_emul_domain_nr(dom_req);
> > +	if (dom_req)
> > +		dom = pci_bus_find_emul_domain_nr(dom_req);
> 
> No, I don't think this is right either. If dom_req is 0, we don't want to
> hv_pci_probe() to fail. We want the "collision" path to be taken so that
> some other unused PCI domain ID is assigned. That could be done by
> passing -1 as the hint to pci_bus_bind_emul_domain_nr(). Or PCI
> domain ID 0 could be pre-reserved in init_hv_pci_drv() like is done
> with HVPCI_DOM_INVALID in current code.

Yeah, I realized that shortly after sending. I will slow down.

> > 
> > A couple observations:
> > 
> > - I think it would be reasonable to not fallback in the hint case with
> >   something like this:
> 
> We *do* need the fallback in the hint case. If the hint causes a collision
> (i.e., another device is already using the hinted PCI domain ID), then we
> need to choose some other PCI domain ID. Again, we don't want hv_pci_probe()
> to fail for the device because the value of bytes 4 and 5 chosen from device's
> GUID (as assigned by Hyper-V) accidently matches bytes 4 and 5 of some other
> device's GUID. Hyper-V guarantees the GUIDs are unique, but not bytes 4 and
> 5 standing alone. Current code behaves like the acpi_disabled case in your
> patch, and picks some other unused PCI domain ID in the 1 to 0xFFFF range.

Ok, that feels like "let the caller set the range in addition to the
hint".

> 
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 833ebf2d5213..0bd2053dbe8a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6705,14 +6705,10 @@ static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> >   */
> >  int pci_bus_find_emul_domain_nr(int hint)
> >  {
> > -	if (hint >= 0) {
> > -		hint = ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> > +	if (hint >= 0)
> > +		return ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> >  				       GFP_KERNEL);
> > 
> > -		if (hint >= 0)
> > -			return hint;
> > -	}
> > -
> >  	if (acpi_disabled)
> >  		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> > 
> > - The VMD driver has been allocating 32-bit PCI domain numbers since
> >   v4.5 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management
> >   Device (VMD)"). At a minimum if it is still a problem, it is a shared
> >   problem, but the significant deployment of VMD in the time likely
> >   indicates it is ok. If not, the above change at least makes the
> >   hyper-v case avoid 32-bit domain numbers.
> 
> The problem we encountered in 2018/2019 was with graphics devices
> and the Xorg X Server, specifically with the PCI domain ID stored in
> xorg.conf to identify the graphics device that the X Server was to run
> against. I don't recall ever seeing a similar problem with storage or NIC
> devices, but my memory could be incomplete. It's plausible that user
> space code accessing the VMD device correctly handled 32-bit domain
> IDs, but that's not necessarily an indicator for user space graphics
> software. The Xorg X Server issues would have started somewhere after
> commit 4a9b0933bdfc in the 4.11 kernel, and were finally fixed in the 5.4
> kernel with commits be700103efd10 and f73f8a504e279.
> 
> All that said, I'm not personally averse to trying again in assigning a
> domain ID > 0xFFFF. I do see a commit [1] to fix libpciaccess that was
> made 7 years ago in response to the issues we were seeing on Hyper-V.
> Assuming those fixes have propagated into using packages like X Server,
> then we're good. But someone from Microsoft should probably sign off
> on taking this risk. I retired from Microsoft nearly two years ago, and
> meddle in things from time-to-time without the burden of dealing
> with customer support issues. ;-)

Living the dream! Extra thanks for taking a look.

> [1] https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/commit/a167bd6474522a709ff3cbb00476c0e4309cb66f

Thanks for this.

I would rather do the equivalent conversion for now because 7 years old
is right on the cusp of "someone might still be running that with new
kernels".

Here is the replacement fixup that I will fold in if it looks good to
you:

-- 8< --
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfe9806bdbe4..f1079a438bff 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3642,9 +3642,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 {
 	struct pci_host_bridge *bridge;
 	struct hv_pcibus_device *hbus;
-	u16 dom_req, dom;
+	int ret, dom;
+	u16 dom_req;
 	char *name;
-	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
 	if (!bridge)
@@ -3673,8 +3673,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 * collisions) in the same VM.
 	 */
 	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
-	dom = pci_bus_find_emul_domain_nr(dom_req);
-
+	dom = pci_bus_find_emul_domain_nr(dom_req, 1, U16_MAX);
 	if (dom < 0) {
 		dev_err(&hdev->device,
 			"Unable to use dom# 0x%x or other numbers", dom_req);
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f60244ff9ef8..30935fe85af9 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -881,7 +881,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
 	sd->vmd_dev = vmd->dev;
-	sd->domain = pci_bus_find_emul_domain_nr(PCI_DOMAIN_NR_NOT_SET);
+
+	/*
+	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
+	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
+	 * which the lower 16 bits are the PCI Segment Group (domain) number.
+	 * Other bits are currently reserved.
+	 */
+	sd->domain = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
 	if (sd->domain < 0)
 		return sd->domain;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 833ebf2d5213..de42e53f07d0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6695,34 +6695,15 @@ static void pci_no_domains(void)
 #ifdef CONFIG_PCI_DOMAINS
 static DEFINE_IDA(pci_domain_nr_dynamic_ida);
 
-/*
- * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida or
- * fallback to the first free domain number above the last ACPI segment number.
- * Caller may have a specific domain number in mind, in which case try to
- * reserve it.
- *
- * Note that this allocation is freed by pci_release_host_bridge_dev().
+/**
+ * pci_bus_find_emul_domain_nr() - allocate a PCI domain number per constraints
+ * @hint: desired domain, 0 if any id in the range of @min to @max is acceptable
+ * @min: minimum allowable domain
+ * @max: maximum allowable domain, no ids higher than INT_MAX will be returned
  */
-int pci_bus_find_emul_domain_nr(int hint)
+u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)
 {
-	if (hint >= 0) {
-		hint = ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
-				       GFP_KERNEL);
-
-		if (hint >= 0)
-			return hint;
-	}
-
-	if (acpi_disabled)
-		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
-
-	/*
-	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
-	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
-	 * which the lower 16 bits are the PCI Segment Group (domain) number.
-	 * Other bits are currently reserved.
-	 */
-	return ida_alloc_range(&pci_domain_nr_dynamic_ida, 0x10000, INT_MAX,
+	return ida_alloc_range(&pci_domain_nr_dynamic_ida, max(hint, min), max,
 			       GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f6a713da5c49..4aeabe8e2f1f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1934,13 +1934,16 @@ DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
  */
 #ifdef CONFIG_PCI_DOMAINS
 extern int pci_domains_supported;
-int pci_bus_find_emul_domain_nr(int hint);
+u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max);
 void pci_bus_release_emul_domain_nr(int domain_nr);
 #else
 enum { pci_domains_supported = 0 };
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
-static inline int pci_bus_find_emul_domain_nr(int hint) { return 0; }
+static inline u32 pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)
+{
+	return 0;
+}
 static inline void pci_bus_release_emul_domain_nr(int domain_nr) { }
 #endif /* CONFIG_PCI_DOMAINS */
 

