Return-Path: <linux-hyperv+bounces-9049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJxqNKQjomnZ0AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9049-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 00:07:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADB1BEDF7
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 00:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6EA430669AB
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39D36BCE7;
	Fri, 27 Feb 2026 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CWNg6pnT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECB28504D;
	Fri, 27 Feb 2026 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233633; cv=fail; b=afZUjHG0bDp1BYixJN2sTe5tbiEkkF/wEE5dVT4FVKGayoth4up5O+JsN2nKVjR0Ps29LTzd/4OQFOxoeHFdvmdm0wMghyDyTsv9mes2bPoCcQh3rF0JPK2G74t4pm0B1PMf1MeheiBMh962lUTaVt6lr+LY54mHHMNY43G9ZY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233633; c=relaxed/simple;
	bh=IaflTVjqpkKQYAMZ1R0fN5P0i99hNKa4j/yQ4CZTniE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CePJUyzsUgIAjzK65SjLyakRIKGrykj8UbPeqJ9VpA5SfJQQTEujMoXkqJFfNezFuynEpxLXZqvvsSJeFY8Q5vQT5nVHb9DOIOvCvDNn2RsUtp0VyRK8oykMTiHweQR20oKfT/G99G7YgMHwnHT2ONdVcqz7F17k+KDXF91Y4Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=CWNg6pnT; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axZAwWh8FAxYzRiLHwsLPwsusFtasRmEr96Ds26j0HdBzguGZBavCQF4UOY2kBQ+yE82OH0HxLBeDUuJE9HfhbCcHH78pK9dQCADjc1MA4/XzEgWzk27NgwYEWEVbfbBt8Od6xN8Ec0eLtvJEdwJGQiiz//PCOykxtHB4hCjnSs88xosDF+qE/JypBLUI3Z4N4D360rTCA+DqPCihO7p9spvFBHbeVgRIjh/Tf1o7gpH5UfSWNKDznI6axEJEuncGrfNGGsDfFcKeyfMWsmsVTwVM1bmYIz03BM71CjnV3YfLz3VhbhxOZkjFqYeWWb/DyUVGUzy3Ps8taimn+O4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsVWygaxJdhv3qYJtg5/PPWbqedTAV24duo6Wu11BXs=;
 b=ago7dSc9oaglJUK20sj0w6rEA4pf/avVhIGgKzss33hqRhgMnXHIqhfowsuBodi5tnvPt6GmoXelY7kGbWdiAP4FbzQ+J0k7/XAW/eBP8vSzLpB/VM2m9cjUNA4NAyjTGtvNJtHr2IggAar+cql9BDDBRq5Zsj5uHUs8VG/ApL5KNVPPEu6EqkfoTTv8+G/Zw4bZToPmmiU8WQe19lwstG22aV1y38ouAoxrzI0SjJ2w2u/ESQT45uqhxx++nkSSV3C8D2hGhRaUR7z/crMOAzkPvSeZeuvzsSZzFAHKWsowWrFjpXM9AZpKecge+xxUMAovd82ZnP3YlsUEivM9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsVWygaxJdhv3qYJtg5/PPWbqedTAV24duo6Wu11BXs=;
 b=CWNg6pnTzWovtwZ4fdx/vJ1yk1i9C9/9Ss086hyr6xo4V+znBNeQZo+NR+I9e6yTshSB8yvl8wR5QLKQi0PDhw5uk3MjcWhVG87DG+YCFVi8KTAA9k383eMlyV27wCNLaEdOWl+W1oRd0TFEMjGUmYeTkS1Zj0PEOWKQVhUe7Pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by BLAPR03MB5378.namprd03.prod.outlook.com (2603:10b6:208:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 23:07:08 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 23:07:08 +0000
Message-ID: <750f39e5-0947-4b55-b33c-613c8b376dfe@citrix.com>
Date: Fri, 27 Feb 2026 23:07:04 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
 Mukesh Rathor <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C
 function
To: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20260227224030.299993-2-ardb@kernel.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20260227224030.299993-2-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0345.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::8) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|BLAPR03MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 771cd26b-4648-4ea7-bc3f-08de7654ee74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Co6pv+g3Y7Qh5M/sKA/vwuSRCz0qAKaiBNd2EUpuZKpfbyb1oN3gczCrSawuqBnExnjrARZ9+Ojs7lvY9HUnaNbqaUaKeen4Is4jts1pM59i3hOik6U+GYa64AENbpvphGtCwzfYlpW3kYLbAq8tW+aMMnpREAQrirc9iXjewDsqPhJkqqw12B62LBBUfHeFXVPvjMP6zG7G81JE+fDu1RSM2h5GSkQkY1G1zMi8YnZIaN47eaF+lsCwYvBsyl5t4yomgJ28EnBFRxBOfbzQJKdhe3aimRl8Qq+G7kPUnys5cJFjnLW8OGow2mfqLWEMYF8y8xuXXQrOZJHNW6QT/lwCTlAh8EJe7gFzaZhUZ2XVKGx4Lw8pu1M35jd1nuUMVnoYNGc2VBtGJ/b5uKdSdA4+f5sxfjQXsIa/nppy6XTaA6SKhvrGc2FxFHHgAsIako4XiEf+HsRJkSuDq6NyG0WSOSVSiN/o/dz96MTFcgpdfYR/e2lRBFYncfph7hnkq6D8o1zOSfscGux4JR0/oHJwtAmefwpGIK6lyK5ptXton00Qy/vbyqwfAK2+8llBu/GtN9fIUxUMWzXfJ3yAXrFymhK6OWYvgU+qDPxYLyHR++P/CUspYNJ0ECe42topQ4b1GL+06oho9qAmYuiw1i7mnk06xqQbScDCXGsPPLxvw0tJhkaBSINUwhRwn7MmFMmjlHgWVF0L11WtNowAJGEGho/EU9zThVpI4sJpqzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEExSjkxaUJKa21ZbVEvdENZOWp0WVpOK1NDdFpaNG9ZQUZPZUE1Y1hVZWIy?=
 =?utf-8?B?TnBjaTJ6MHRNRElkRk1UY1hqa1NxbTFKL3ZhNWRkMzNJTjRjUTNYQzc1WlFG?=
 =?utf-8?B?WWRzVTBxOS80akdtNkdTRVBldEJaTzVmVXpmamRPYk1XQWxsVGc4TTltUVR0?=
 =?utf-8?B?eG80dFF1RWNmY2RRdkd1TWRIcFB4Rm9vMVQxRy9vV3dwWCtibWRqcnliOG1p?=
 =?utf-8?B?QW1Ga3BjRmVjTW5IaGNJWmxtSjhLME5Odm5QYkxvSEtrUDhGWlRuWUw4Zmdq?=
 =?utf-8?B?aDFkUXMyME45ZWc3MVg0V2x0K1JYbnNsRmZNeUlvMjVhMlBLeG9sRlo5Vm5W?=
 =?utf-8?B?VmM1a0pWWWl0Q29QOEZZMCtwVXBGY3BPb1ZjYW1sb3NTM3RsUWdZSERrenZM?=
 =?utf-8?B?ekQxZEY5VkNjajFJY0xxUWFWZldQMENqMHo5aCtRb3p6WEVMKzZlanVjUDBD?=
 =?utf-8?B?cjRRV0xlR2FjTTJNR1hsbVVDc2dlODByR2VkcVI2bHNzZko1WTcxQzUxODRV?=
 =?utf-8?B?Y3lNYlNocXNEMUphZFNvdi9tUUR4SXVYckdGQU1QVkUwRkYyb05yRUNSMGxw?=
 =?utf-8?B?SWhIZk5sWTlFN1VkdzI1aE5sMmN6TlJnTG4xVVprdityRjJZM3YwWitQVXNF?=
 =?utf-8?B?Mk94WkJXVTNLSnUrZG8rZVNQOXhtZkhlMWZXNkZGcmFzbStPNERKZmxWWFlP?=
 =?utf-8?B?QnhtQ3ZEeVh0d3dYajFGRzRBR0JzN0pWbVM4Tm9WTVZObktEc2ZuZExtQWsr?=
 =?utf-8?B?bWlTMkczNW9nZlR1dkJxcnUvWmxVSVdpdHBZT1FzTitPdFZHNU00MFo2ZGh3?=
 =?utf-8?B?NUx2K1FXR09WdUJTY3h5dTlHZjhhRUNrc1VJSzg1V0NiR0ZLbjFoa3V5WVFI?=
 =?utf-8?B?OFE2UnlrTlNnYTZxL1NabVFYMDVYY3BuYlJBdWRyQnRsSGhaYWZybThVQ0lu?=
 =?utf-8?B?RHU5NTF4ZXhhcHlJZXdXbEtETkZsUmJzRkVoQ1ZuODhyUWR3UUdXVkVZbkRM?=
 =?utf-8?B?VUtYSGZ0TEZHUVpBcmlHbWM0SGdyN21HSncwOTVZdmo4V0hVOTl6Y1dtdjdz?=
 =?utf-8?B?WVlCVitqTDl0d1A1UWJ2a3R4LzdtRUo5dktwaWxDZHdIOWhSQ3RrWGI1RXNG?=
 =?utf-8?B?RmxobzAxbk0vS09LbnkreHNLaW1sTzc0UFBiMzNFNUdGMHYxa1hsbEJJaTMw?=
 =?utf-8?B?Zi82cFhJSjJVc3N1OWlqOHdmbEJ5UmF2cjh1SXFiL1ZoWTVPVGFQS2FJdjNu?=
 =?utf-8?B?OUh0a3RYeVdMVVhzYnpWQmhweWdOQmZ1K2c2Z3BOc0ZTTmx3RzJjZmFwUnRx?=
 =?utf-8?B?YkRVNGwrYnZwdGZwY2V0RGxxVC9kaU15aTU2c2JJRXI4bTZpVENqdEdxTlhw?=
 =?utf-8?B?eG13S2xDQU5wNjkzU1VPa01ySTgyK0hvWEZRM2RLYjhCRUVDd29VWnBITEtx?=
 =?utf-8?B?emlWY1QydDNScDNtQ0hUdnc5VHpRSUI3SFh1L0hvc0IvdEpwbHRKZSt0Q3py?=
 =?utf-8?B?OWliclJTWngzMnVlbUZlbEpPZFNjUG93ck9LejJhRCtQb3VOaW8xc3BNOFFm?=
 =?utf-8?B?MmJBWHZNZlhaSXRsRWx6cXZ6OS9aRjFhaWR2SnVQTGFwd0VIWEtMWWphNXRr?=
 =?utf-8?B?OGl5VmFyLzU2dWtHR1ZDeEJVdEZIQ0U1ZTBqMFVjNUZSWWZQTmZ4QmN6NjFu?=
 =?utf-8?B?V1NHeHZ2L0wzSWx4b0UzY2t6VWtXRFBSQldPcXYyYnFHRHovaS9IMkRpTW9L?=
 =?utf-8?B?RFRPdldGSDIxSkEvRWxRdEx0bEo0bjkyNHJBWkdVWnptQ2lNSmVpd1dYVlpm?=
 =?utf-8?B?SGpjQnhyYjA0U2FVclp1dDZINzBwRnhmT0hHOFJYcEZjMkw4ajBGK0NMUTl1?=
 =?utf-8?B?Sm1TQUl1OTdkcXcxa0JIaTFQUTZLR3dRQ2dHa1BER1FjSzkxOVU4TGlISHhJ?=
 =?utf-8?B?ZDRYcklseE9PZEkxQUpmYXJYSWFkZEg0VmUzTGwxektXR0RjU2pJWklBOW4x?=
 =?utf-8?B?ZWdQRnhsdGNQdVAyYnBUT2JRSGV0WXZtK3k1NFNENnhqYWd1NGIva1lYRUJ3?=
 =?utf-8?B?bHlnZGZSd1hrK1VsNERQdFk4NWZsVE1nNHFmaFFMcGxZTjVQTUJKem9yZ2dr?=
 =?utf-8?B?eGg1VW1vMFhMalBQakNEUlRNSzZOZm15cGd6bTY0dVgvN0ZST2Y5WmRWM2la?=
 =?utf-8?B?clBQWERCS09kWG5rWDBleGx1RmZTOUZNZ2praERWS3kxVllhcmkwYjBXaW1t?=
 =?utf-8?B?S2s4UnlZUjhhblc3M0YvdkE2dWNzVmNHZ3Vmem1wc2ROdFRRQ1RJSnRLTkxu?=
 =?utf-8?B?emxFMFp2RHQ3czh5YkdpNU9nTDlncGFwb2FjZGNIQ0cwcTBGbHllQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771cd26b-4648-4ea7-bc3f-08de7654ee74
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 23:07:08.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxApOD01PdXy5Dhk3kFpX7xTswp7ZtN/w92eqC97mu+dyKwa4PSThBFDsSmFeKN6j2tJPIGWjuUcH5LQV1hK7tCzbo0vxk/AkZpzhGpJ604=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5378
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[citrix.com,kernel.org,linux.microsoft.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9049-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[citrix.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[citrix.com:mid,citrix.com:dkim,citrix.com:email,hv_crash_ctxt.gs:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hv_crash_ctxt.es:url,hv_crash_ctxt.ss:url]
X-Rspamd-Queue-Id: 73ADB1BEDF7
X-Rspamd-Action: no action

On 27/02/2026 10:40 pm, Ard Biesheuvel wrote:
> hv_crash_c_entry() is a C function that is entered without a stack,
> and this is only allowed for functions that have the __naked attribute,
> which informs the compiler that it must not emit the usual prologue and
> epilogue or emit any other kind of instrumentation that relies on a
> stack frame.
>
> So split up the function, and set the __naked attribute on the initial
> part that sets up the stack, GDT, IDT and other pieces that are needed
> for ordinary C execution. Given that function calls are not permitted
> either, use the existing long return coded in an asm() block to call the
> second part of the function, which is an ordinary function that is
> permitted to call other functions as usual.
>
> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: linux-hyperv@vger.kernel.org
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: apply some asm tweaks suggested by Uros and Andrew

Looking better.  FWIW, Reviewed-by: Andrew Cooper
<andrew.cooper3@citrix.com> (asm parts, not hv parts).

Two minor suggestions, probably left to the maintainers digression.

> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index 92da1b4f2e73..1c0965eb346e 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
>  	native_p4d_clear(p4d);
>  }
>  
> +
> +static void __noreturn hv_crash_handle(void)
> +{
> +	hv_crash_restore_tss();
> +	hv_crash_clear_kernpt();
> +
> +	/* we are now fully in devirtualized normal kernel mode */
> +	__crash_kexec(NULL);
> +
> +	hv_panic_timeout_reboot();
> +}
> +
> +/*
> + * __naked functions do not permit function calls, not even to __always_inline
> + * functions that only contain asm() blocks themselves. So use a macro instead.
> + */
> +#define hv_wrmsr(msr, val) \
> +	asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "memory")

How about naming it hv_crash_wrmsr()?

It's important that this wrapper is not reused elsewhere.  Elsewhere
should use the regular MSR accessors.

> +
>  /*
>   * This is the C entry point from the asm glue code after the disable hypercall.
>   * We enter here in IA32-e long mode, ie, full 64bit mode running on kernel
> @@ -133,49 +150,35 @@ static noinline void hv_crash_clear_kernpt(void)
>   * available. We restore kernel GDT, and rest of the context, and continue
>   * to kexec.
>   */
> -static asmlinkage void __noreturn hv_crash_c_entry(void)
> +static void __naked hv_crash_c_entry(void)
>  {
> -	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
> -
>  	/* first thing, restore kernel gdt */
> -	native_load_gdt(&ctxt->gdtr);
> +	asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
>  
> -	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
> -	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
> +	asm volatile("movw %0, %%ss" : : "m"(hv_crash_ctxt.ss));
> +	asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
>  
> -	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
> -	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
> -	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
> -	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
> +	asm volatile("movw %0, %%ds" : : "m"(hv_crash_ctxt.ds));
> +	asm volatile("movw %0, %%es" : : "m"(hv_crash_ctxt.es));
> +	asm volatile("movw %0, %%fs" : : "m"(hv_crash_ctxt.fs));
> +	asm volatile("movw %0, %%gs" : : "m"(hv_crash_ctxt.gs));
>  
> -	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
> -	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
> +	hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
> +	asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
>  
> -	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
> -	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
> -	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
> +	asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
> +	asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
> +	asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4));
>  
> -	native_load_idt(&ctxt->idtr);
> -	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
> -	native_wrmsrq(MSR_EFER, ctxt->efer);
> +	asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
> +	hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
> +	hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
>  
>  	/* restore the original kernel CS now via far return */
> -	asm volatile("movzwq %0, %%rax\n\t"
> -		     "pushq %%rax\n\t"
> -		     "pushq $1f\n\t"
> -		     "lretq\n\t"
> -		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
> -
> -	/* We are in asmlinkage without stack frame, hence make C function
> -	 * calls which will buy stack frames.
> -	 */
> -	hv_crash_restore_tss();
> -	hv_crash_clear_kernpt();
> -
> -	/* we are now fully in devirtualized normal kernel mode */
> -	__crash_kexec(NULL);
> -
> -	hv_panic_timeout_reboot();
> +	asm volatile("pushq %q0\n\t"
> +		     "pushq %q1\n\t"
> +		     "lretq"
> +		     :: "r"(hv_crash_ctxt.cs), "r"(hv_crash_handle));
>  }
>  /* Tell gcc we are using lretq long jump in the above function intentionally */
>  STACK_FRAME_NON_STANDARD(hv_crash_c_entry);

How about fixing the comment to say objtool?  It's not GCC which cares.

~Andrew

