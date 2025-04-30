Return-Path: <linux-hyperv+bounces-5257-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C31AA5349
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14B81885093
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97AD1DE891;
	Wed, 30 Apr 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G4oN2vO1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D101C173C;
	Wed, 30 Apr 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036303; cv=fail; b=rMw/VQfFNrgC/PfW/dGbQO87IT3byuA1NLSTWQiXNrolSGzsBmbk4dJ7q/UgD/o66hAbRc1X4jAyxyA6PBB/OS4539KLBxB/zIuphodn6PdxHUrU6uw9uzJN6EfOTO5QW0w95ca7KM1VHYmB5TfPslrNNup684WyDvB8ti1TnUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036303; c=relaxed/simple;
	bh=hJHV+F1YCBzpH49XsbQWXaMAE3Jr/GwHfpBLFIslS6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LSoBt+aFlcqnFd+9WbcMha94f9Nrg2YuCBn+plPo10VIru3tXZGOKbU/9kmh5sJZ2MOyH539M1IdNsSgy+On6yTyw/9tCoJCfb6rwgdErdCXFad/HxtKPN2C6NMbqp9RQLdaPlhi5KrXDJaFv+l89JtVgctG/WXgT3ej17zsir0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G4oN2vO1; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO47CDp+SVgIEswcHj99K+/c4a2z4kPwVavMAljOAXyWp689Q5/qQ1VwphZPLbhSn+A0CnjumgdrDe3mVyqwt+qJC5PMsOWG0L69UOHknDBfy0crseDlfYiky9JmwkAbwhjv3dndrgCIgjDeGqnCypDcn4Lv0GU6jqkR9liZfauX6UGS+7IPriwnTBa85slo+B6KMJ/rrWghBNd+14Rc2Fsuq5ZgxgxTWuEDaKXTIyP2RBxLqtnSiaCtf+la8t96QvhQr5q+TCx3n82fVANr3gwu7QvtucT9VaLtsMUqU195sbeNVUIRbRvH8Nsb0tpnNvXB5ojsjqvLRG0wFZABOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tt/cqqErvlf9JYh6oY1q78S4Sav0guswUYd8qNSCbs=;
 b=tuk7XG2WsP2U4wJG3VJeXMrqySaLAy9zSoD84s4hpkMI/WotO2wliOuIRIwZMEv/pampmjFYrEm4uFuDzNKiDvbosWrFku+58gHrZ+a9szfv4LARCYixrbVubnD3njoJAGOVjXSKKBxXEoe/yaS7jTJIemuSyCUq3WKqfyRmAcQKkRLpmyqyyLN/wHgxvMuEdEpq780l7+tQQpjp8ui3RsPFbS4gKNcgg7YcFZN3gjVoUtjYVNfV7ksnbYkiB7Nyhcqv6NnJmORZoiXwPpljC8WpPy1xhWKENOX8EKNo/NDdHQp1gMmrgzH5kJrb9a5xrQe3f22oroKcE+LzLoGsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Tt/cqqErvlf9JYh6oY1q78S4Sav0guswUYd8qNSCbs=;
 b=G4oN2vO1RCl6GS4+Yao2MYRRDmRbf9HgG/IoJ9JKbbPEKy5xqkpMrlKZqvFQUIXhfaDmnrWWNKFbDp+ao1OXF1RfmJR5eYiNxwJUCS4sIerDHCZXjQzHEF2Ssoaf5AlmAD4Gbd6cCiuf2Mi59ywSrwYff1OoCbvKUS9PEzz2m60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 18:04:56 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 18:04:56 +0000
Message-ID: <addab958-791b-fbaf-4549-6e426779e9b7@amd.com>
Date: Wed, 30 Apr 2025 13:04:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH hyperv-next v2] arch/x86: Provide the CPU number in the
 wakeup AP callback
Content-Language: en-US
To: Roman Kisel <romank@linux.microsoft.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, dimitri.sivanich@hpe.com,
 haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
 jacob.jun.pan@linux.intel.com, jgross@suse.com, justin.ernst@hpe.com,
 kprateek.nayak@amd.com, kyle.meyer@hpe.com, kys@microsoft.com,
 lenb@kernel.org, mingo@redhat.com, nikunj@amd.com, papaluri@amd.com,
 perry.yuan@amd.com, peterz@infradead.org, rafael@kernel.org,
 russ.anderson@hpe.com, steve.wahl@hpe.com, tglx@linutronix.de,
 tim.c.chen@linux.intel.com, tony.luck@intel.com, wei.liu@kernel.org,
 xin@zytor.com, yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250430161413.276759-1-romank@linux.microsoft.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250430161413.276759-1-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:806:127::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: b88b2582-476b-4c39-6c68-08dd881183a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0luMzhYb1RadVRoNGlkd1VRMENsNitzQlJKRHRwR1diaklCM1VTSWdxNCs0?=
 =?utf-8?B?bUJFOWltL0hsRkF5OFE1YlowNEJjYjRmeURmVHVEM09YY0c2UldNNjFhWXJ2?=
 =?utf-8?B?cU9qKy9OZStNeWY4RkY3TFdDeStsUHhqbGFhWjBmU0U1c2RadmNYMzM4V2cz?=
 =?utf-8?B?SHlKUGJFYkhMSFF4Ymw2K0lSOTJTaDhQSFpkdFprQmdOZmpUL3dOVlRZYStn?=
 =?utf-8?B?QTB5dVRwR0FTZVlxSXRnV3hsalpNZ1ZCbGF5ZzdQaHpEWG93L0pXNFpxd0w0?=
 =?utf-8?B?bTFGOTNvOEthcGVVcndreDQ2SUd5RkVPSFA4OXlnY2F0VjVnNGluN2w0V0tv?=
 =?utf-8?B?eTVGTFRaVENNWE1HOHdmckpYaCtocUxrRVNFSkZpZlV3TkdDWGNGUTQ2Wnpm?=
 =?utf-8?B?aXBRbFRmajBTTE1YTC9IY1NhREVoeUROeVVxc2RRZkphWENLM3RjVEV2VWVY?=
 =?utf-8?B?VGZLNTJmYVpjT25neWwxNG0wSnpXclFkNElQR3RBTUZhKzhDRjB5dk8rbnJC?=
 =?utf-8?B?anAxbGN2SUJ3Vkc0VzJFZXUyT1JwN0VKeVpSa2RvMVJhajQ2bXpsQ2VuYndL?=
 =?utf-8?B?WjZoQkUxV3UxK255SjVNQzJNejB3Ris3MVppeEYrUlhpZ21RUWl0UEhMRWVW?=
 =?utf-8?B?TGZiNTkrTFVTbmNlVGJNSlp6L1h2bUtyZStDRkhJcWN5VGhtS0dTY1EyMC8v?=
 =?utf-8?B?ZDFFeTlUS1U3Nzl0c1BhNFJMd2lndlpvWFl2MHRCMkIrV2UvVk00U3V6U1Rm?=
 =?utf-8?B?U1FkMEhwZTFSVmxDRGR0TW9QYUt1eDM5T012aXlLM2t1SUxIWVlOZHBqZE1T?=
 =?utf-8?B?eG5meUVETUJJZU5vMVlIbWdqQXlMSmVBYTh2U2lwaHBQUUpSNDcxNkRKaisy?=
 =?utf-8?B?cVl5amszNVdCSklVbGNmSm8xaCtRSTJPMTROZkdDWHBFam9kSEVhUVpaK0hG?=
 =?utf-8?B?Z1cxcFRpSjdWY1dTZnZPMGk3UHJiUytPS2tldmdlakN3dDBkc216M2pLNmxy?=
 =?utf-8?B?OEtqQU1KWDFmT21HYTlzeHY0Z1lsTXB3dDlqZVh4L28yeWlqcFpwYUVsRTBY?=
 =?utf-8?B?aUt5M1A1M0gzMVhVRjA2enFZSEl4NCt0OFAzWmZqbVR3Y3lnTUJWRWV3U29t?=
 =?utf-8?B?cFRNT1N4L21EZ0lJenZsVzMvdVJEb2J0TWlsdG1GdTU4UlJDS2JEdStiajRp?=
 =?utf-8?B?U3hnTTNHRFhIbE1XajFQNkIxelZZaGk5eEo1SFpuMjMzeng3OXZnZVNUeVBF?=
 =?utf-8?B?aExTV0FGTG0vaHNVb2ptbXQzejV4c0ExMFNGNldKdVFNeWJnNENtclhmS1Zt?=
 =?utf-8?B?YzZneFBlN1RhT0hYMnljUUt1aHh5dU9mTm1FZE5YU1YvblAwanlPSWRjTUl3?=
 =?utf-8?B?MTRMYlI3L2hmVjZIWTZ1V3RaNW1QMGQ5eHdNVmtaYUV6MitEUmlnbkhpc0VW?=
 =?utf-8?B?MVUzNWZRVGhiekx5RTZKSDl1bkNqejlvOGhTLzUvMGU2MW9uc2VScFpwWEVu?=
 =?utf-8?B?OURCZmE3QzR5Vjg4NFZ0aXRoczB0aEwxQmxkNFR0eGhFMHlCajBWOXNocEdM?=
 =?utf-8?B?aGY3UitGOGNaOHBqUTlibmoxZFVaUk1DOVVjV0N6NkQvWW9vSGpCOUFrOWln?=
 =?utf-8?B?UlBsM0t1eS8zOENzQUJQbXJOOGhBODNSS3k5TzJPanRNd01FYUdQeVVHOExX?=
 =?utf-8?B?NlpCemVZeWdDaDU2bHdudVVESTJEWVYyNVhDVDZoQjc2aGtyK2VONkFDTjJP?=
 =?utf-8?B?UTNQK2JkTWMrQVFDTUNLS2lQTWpPN0tRelNJTzZYaXdjSngrY1BhdlJQZ0R5?=
 =?utf-8?B?NkRlK285d04wbGMzdEc5WEhQTndNNGxJZStYSGRTTTZCT25sdkJ5b2Ywc3JQ?=
 =?utf-8?B?WFU0ZDFYWjJhcmFJK0tCZ0pCY0pRMUQybHpkK3JnMzkwTDBsL3BraDc1cUtM?=
 =?utf-8?B?MTBSb09aSW1BQVJ2cXdaYWtTWlhSM2NSYTlxR2dJRFQvTjlDN0N5S2x3WFVD?=
 =?utf-8?Q?7lygbENGfApVx7JLq9x0TX14SXJb/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0hwYm1QYTJ3L1czeS9BUE9VRWhuYW5mUEVNM2hnUThaV1UzNDczbUFZcjJr?=
 =?utf-8?B?ZUtHZDFUSnYyRjFoZFJBZENjYk1RTkZWNEhmRnlpUERzVDlnKzIzb3BIQTNK?=
 =?utf-8?B?MTJ3d25WUzVuSFgycFlDY1ZLbk1FL2FLbzRLY3VpRW4xZFBIUGJueVdlU0dV?=
 =?utf-8?B?Z2V1Q1MvNy90U3ZvYjhyUnFFZk80QmQ0blpVK2p0VitXblRvSDRaQnlnS2t3?=
 =?utf-8?B?ckk1NWRaQ3RCY1RJdXovcWFaZFVJM0JUWXVpTkhkYWd1MjNPVThBRzJxSTRx?=
 =?utf-8?B?clZFSU0ybS9sUWI3N2dYK0EvTGpGSlprZ3Yra3dLSDJEcXlJR3o5bnVxM2l3?=
 =?utf-8?B?UlgycjZpcFMvZjU1OWk2OURlakhCdVpKY3FNU05hbFE3djRCNTFFcUlXLzJy?=
 =?utf-8?B?cy9venplcGdyN1VsSTc3L1BpOWp3WXRhZWJKQ2x0dE4vcE1FYUM0Zmp6WjUy?=
 =?utf-8?B?KzdtMDBOUDlvWWZzRVdGMmQ2R2pjc2tVQlBlSVZYc1lGeXVjZlZRb0VqM0ZJ?=
 =?utf-8?B?M3FmZ2tCTjVUVExFSmJ5Z0wvV0JyZjJNSVZwRTB2RkVFU29rWFVhcTA1M0Zk?=
 =?utf-8?B?ZkRLOTcrcE5iYUs5dFpGTWV0MFdOQ0ZiajVzZEEwYUZKWitNMXE2TUVLdmhw?=
 =?utf-8?B?czh0MkRiSC82NWJhemE0OVNmYkJxa3JIc1RRMjZ1ZnpJaXEwcmI4SmpTc0JN?=
 =?utf-8?B?YkRrTUlDT0R3VVFIV2Y2cFBoT3JtWVhYb3pmNmxlbWI0RnU3b0ZYbUZiSjIy?=
 =?utf-8?B?TmNlYkVodWhDb0daQmgwMDh4MjJwb0JBUzJ0MjJBeXovYkhqVGVPTkhmRnRt?=
 =?utf-8?B?R3UwY3JKN1drc09KZFpvZkFLVkdxUGdicFhrRm1veWZJTUNYTnVJa3gxZmpX?=
 =?utf-8?B?UzlXOXRRWkhITjdUWUpZdkZZNlRVekMrd1BCNStSUzhWYzFuVUxqRWNXMDdX?=
 =?utf-8?B?dUJCeUxhL2t5djFkU3RRMjdkSlhTNno5cE44U1V0K1dxMVNZMk1ERUdmQzUw?=
 =?utf-8?B?ZEp5V1krbTVYdjAxTExXNnQ3ZWVleUViOTk1NkhOWUZPZTd3b0wzanZYRkJZ?=
 =?utf-8?B?YlJndHhiYU03dytQbjFjcDBTN0tjMVhSRSswcWplZWlNNUR0bkJtTzVUekRQ?=
 =?utf-8?B?OEM1RkdtVnlsWEQyNHhzUlhIeUZuUUtQWEhuSnZnZC9LcUJhQUcxcmdUeElh?=
 =?utf-8?B?eXB5UERLY0VWcENvSHRBYThiYlRIcDJnWXB3SmxLcXJpcVlRd045RWw5MXRX?=
 =?utf-8?B?a1I5dEYvK0JROWh2UUxnN0RiWTRPNDJobXRGZVA1SkV5c1pwNW1RSTU1RTlW?=
 =?utf-8?B?RGNwangyQloxZ1IvZ20ySFNpSFZxSkk0UkY1ZVlDelhqVWlCL3F2aVM1ejdm?=
 =?utf-8?B?NVdJZUxINkNEcFRzQWlhTVc5OUI0QXN6VjErU25Qc3Y5KzJYVk1OZEFLanF0?=
 =?utf-8?B?OS9GaWJEWWd4T1BVa2NUV3ozVzZwU1BqakZCTzNuUUJyL1c3U1I0akh6ZU84?=
 =?utf-8?B?aDJaVEJjSHFrS1dORnU4c1NucTZOOFFVWDhXNDVRbWxSRlFoZi9qQm1LL3U3?=
 =?utf-8?B?ZUFNUEhKK09wWG9zQnJPbVNHc3NnQTFVbnJXVXpmdWRoY2dDMlZMUldaQm9t?=
 =?utf-8?B?RnRwckNtMmVmbVZvQUMxRHkxdU9GNGJzcGFMMVNrVURyaDJUS0NxL3VHbVVY?=
 =?utf-8?B?T2phS2ZFeGJoc0dsNVFIMnlXOFRNZmUzRnBmVTZ4ZXdDNDdCTjFrMGc1UXo5?=
 =?utf-8?B?UmpQdTQwMFJXQVhqUnlYSGVhc1ZtMUNHaWFTTnppUjM2SGI1aWRIZGFBR2w0?=
 =?utf-8?B?QXY5alNuZDg2WWZkNitYSlhpOG1xRWlFeXduTWtKWnFjbVYrd0RKWktpUklN?=
 =?utf-8?B?NWRpRHJGS1dkNW1UTmlYeERJNHYrV2lBb0Vqcjg3OXA0cTc3L3VxRk9yKzhH?=
 =?utf-8?B?YnVtK2x5SCt4SUh2emRISC90ODZreVJDa3NQMkRZNldEZDdKSk9lTWZtRUJD?=
 =?utf-8?B?ZUljWHZYUTMydWEwVWR6OWVkRDIzQnNZMnFnZ3NjTG9HNWNkMHRqOTlQR3Nu?=
 =?utf-8?B?V0FycGw4eGp0U3pqVVVwSFhYQVpQUS9USzhRRXJMR3g5ekFyTEI3KzFTd1Yy?=
 =?utf-8?Q?w1/t8PSOWTiuCOjB4MTsvkC8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88b2582-476b-4c39-6c68-08dd881183a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 18:04:56.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24JTGuKwN8C5C3EOHCnh/jmi+mXZi06RCP4Axg37gsz4YybV43ExhMOLgYs8En+e3S4qD/K/gT7ezSMH1n9VHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

On 4/30/25 11:14, Roman Kisel wrote:
> When starting APs, confidential guests and paravisor guests
> need to know the CPU number, and the pattern of using the linear
> search has emerged in several places. With N processors that leads
> to the O(N^2) time complexity.
> 
> Provide the CPU number in the AP wake up callback so that one can
> get the CPU number in constant time.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
> The diff in ivm.c might catch your eye but that code mixes up the
> APIC ID and the CPU number anyway. That is fixed in another patch:
> https://lore.kernel.org/linux-hyperv/20250428182705.132755-1-romank@linux.microsoft.com/
> independently of this one (being an optimization).
> I separated the two as this one might be more disputatious due to
> the change in the API (although it is a tiny one and comes with
> the benefits).
> 
> [V2]
> 	- Remove the struct used in v1 in favor of passing the CPU number
> 	  directly to the callback not to increase complexity.
> 	** Thank you, Michael! **
> [V1]
> 	https://lore.kernel.org/linux-hyperv/20250428225948.810147-1-romank@linux.microsoft.com/
> ---
>  arch/x86/coco/sev/core.c           | 13 ++-----------
>  arch/x86/hyperv/hv_vtl.c           | 12 ++----------
>  arch/x86/hyperv/ivm.c              |  2 +-
>  arch/x86/include/asm/apic.h        |  8 ++++----
>  arch/x86/include/asm/mshyperv.h    |  4 ++--
>  arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
>  arch/x86/kernel/apic/apic_noop.c   |  2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
>  arch/x86/kernel/smpboot.c          |  8 ++++----
>  9 files changed, 18 insertions(+), 35 deletions(-)
> 

The change to wakeup_secondary_cpu_via_init() isn't needed but does
provide consistency. I'll leave that to the maintainers to decide if that
function should remain as is.

Otherwise,

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 82492efc5d94..e7b6dba30a0a 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1179,7 +1179,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>  		free_page((unsigned long)vmsa);
>  }
>  
> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, int cpu)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> @@ -1187,7 +1187,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  	unsigned long flags;
>  	struct ghcb *ghcb;
>  	u8 sipi_vector;
> -	int cpu, ret;
> +	int ret;
>  	u64 cr4;
>  
>  	/*
> @@ -1208,15 +1208,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  
>  	/* Override start_ip with known protected guest start IP */
>  	start_ip = real_mode_header->sev_es_trampoline_start;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apic_id))
> -			break;
> -	}
> -	if (cpu >= nr_cpu_ids)
> -		return -EINVAL;
> -
>  	cur_vmsa = per_cpu(sev_vmsa, cpu);
>  
>  	/*
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 582fe820e29c..5784b6c56ca4 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -237,17 +237,9 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  	return ret;
>  }
>  
> -static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
> +static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, int cpu)
>  {
> -	int vp_id, cpu;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apicid))
> -			break;
> -	}
> -	if (cpu >= nr_cpu_ids)
> -		return -EINVAL;
> +	int vp_id;
>  
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>  	vp_id = hv_vtl_apicid_to_vp_id(apicid);
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0039a90e9e0..ba744dbc22bb 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>  		free_page((unsigned long)vmsa);
>  }
>  
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, int cpu)
>  {
>  	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
>  		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index f21ff1932699..a480f7626847 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -313,9 +313,9 @@ struct apic {
>  	u32	(*get_apic_id)(u32 id);
>  
>  	/* wakeup_secondary_cpu */
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, int cpu);
>  	/* wakeup secondary CPU using 64-bit wakeup point */
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, int cpu);
>  
>  	char	*name;
>  };
> @@ -333,8 +333,8 @@ struct apic_override {
>  	void	(*send_IPI_self)(int vector);
>  	u64	(*icr_read)(void);
>  	void	(*icr_write)(u32 low, u32 high);
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, int cpu);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, int cpu);
>  };
>  
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 07aadf0e839f..abca9d8d4a82 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, int cpu);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, int cpu) { return 0; }
>  #endif
>  
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index d5ef6215583b..d95c806f0e93 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -169,7 +169,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
>  	return 0;
>  }
>  
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, int cpu)
>  {
>  	if (!acpi_mp_wake_mailbox_paddr) {
>  		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
> index b5bb7a2e8340..cab7cac16f53 100644
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int vector) { }
>  static void noop_send_IPI_all(int vector) { }
>  static void noop_send_IPI_self(int vector) { }
>  static void noop_apic_icr_write(u32 low, u32 id) { }
> -static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
> +static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, int cpu) { return -1; }
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 7fef504ca508..f8000555127b 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -667,7 +667,7 @@ static __init void build_uv_gr_table(void)
>  	}
>  }
>  
> -static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
> +static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip, int cpu)
>  {
>  	unsigned long val;
>  	int pnode;
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index c10850ae6f09..4b514e485f9c 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -715,7 +715,7 @@ static void send_init_sequence(u32 phys_apicid)
>  /*
>   * Wake up AP by INIT, INIT, STARTUP sequence.
>   */
> -static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
> +static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip, int cpu)
>  {
>  	unsigned long send_status = 0, accept_status = 0;
>  	int num_starts, j, maxlvt;
> @@ -916,11 +916,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>  	 * - Use an INIT boot APIC message
>  	 */
>  	if (apic->wakeup_secondary_cpu_64)
> -		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
> +		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
>  	else if (apic->wakeup_secondary_cpu)
> -		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
> +		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
>  	else
> -		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
> +		ret = wakeup_secondary_cpu_via_init(apicid, start_ip, cpu);
>  
>  	/* If the wakeup mechanism failed, cleanup the warm reset vector */
>  	if (ret)
> 
> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95

