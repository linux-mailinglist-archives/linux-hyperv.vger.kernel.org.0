Return-Path: <linux-hyperv+bounces-5494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86878AB5DB3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCFE1B471DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E61E5B9C;
	Tue, 13 May 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzOfVblg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nNSco4LT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF51BC3F;
	Tue, 13 May 2025 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168494; cv=fail; b=cdCa61W6bFoQa01x0kakKJ9lQZwDBc5a1Qy5ML4IjSo3OogQP8uuv9YjuI/nQUggIhYHTLCzI0fquPop/G9Zz0AqDH2JVNjf4cH19a4pE8MoFmz2DA6Q7iQZlFsSTdJ+Uf9k7YLaIJuYYChPoqA8DPygwO8PbuJHaZsQGFWEvAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168494; c=relaxed/simple;
	bh=5yB/6g9e/K3z9694oEBYOUuiz0z0/hibD5TXUve8f7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+KgDbVvduJEi5YFTadVJPcbln6sf7tT8GgNAjnPRrvPxACML/qob+YUJitOP9gdMphIU62f2VKZPwvbuHNdguxnGDDEgFFZMAHArSqswp655qDYI3Fv/8qx/KeCvq6PrIgVc2D9pCYjdiKtaUVMRitG+CF73p0X0KEykZYlYuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MzOfVblg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nNSco4LT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DKMo8Y009012;
	Tue, 13 May 2025 20:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7kR0vHOhXJlKoRUfERXNP8Cajv+YSIQuhc1x7OVadI8=; b=
	MzOfVblgpurasq+uGXGB9SBM5g3Mjn32iHlYs2RcHUSAiPaknODu++ULIRtE3D2I
	S6OoQSa6l6PtdV2nQJkFIfJsHPnfNnuJV0ty90vTBHAeAPmyT3bqqNoTFSW1P+9m
	v02XqpPKJdd2IRadHLjbkCtgsuf42OBPR66gG61BA82RLfkHJ7wRedkE6tfjV7y5
	VyFmThYyDx+xyH9mXiTiFLv1kkXS9NvnmtuqeydpA8/HW4z99TRv4tvD98Sinb/G
	Y/arN/ZqjUlFe+dBKdi9aMlovJVuJUFgBkxoxF/15WGZ8vxMGgI3WIS8tuRsqe+O
	NWepmiJTlnxk7ohKxtFVNg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccr80k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 20:34:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIsZcm033311;
	Tue, 13 May 2025 20:34:45 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbs8ba7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 20:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2qKcd3If+msx1cC190pDzoyCktJYCPQ28HDNiFxhlYurTsIfkuGe4OBSheaJJASkiA/62A7bPKfXeEYqpNLnyXwNQqo37FL6aOB7iID4Qiam+jTpAP+6FV8iXhn/5k8x/hoUMgejglyaBbBrJyFuu5gOjkWpZYCyctTcBLV9TDBV34Mp/WX324DmMBCNQDNzYFK+URkK2EDISxLw70jTHyUPOEuorYtAvuJWWr17g3lvsvknihCNGRGC4zxP8h5jHKb5W7KWYbHCXh7FakbkLU1B9V3437bCg4uf51Rm8//xY03d/Yb2crAn0VNh7LLUmO/cHnv8uMjPiD6UhGNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kR0vHOhXJlKoRUfERXNP8Cajv+YSIQuhc1x7OVadI8=;
 b=OtW69HYBZdMYE8jz6Xi4yL1nwuipquCq4yBj9o48EV5E+i3wBNahKqvwG0rvHWDB4krIfhHOibH8awK3gNLiOiPQx/J6VP1qMQuOzG+QvcU0B8YJssG18u0oSHchYSPfOLVOreNgdDZkO8vwxwpX/R5baJh0JK3ZZy+Y6ZoPL+ooPDg9JVMSID4aiNsqHZ2tNlsTEeyMXTfqYPiEla0t9eMd+KyJHEd0xyKLUNUH4j8EEPRMCSu8F59BotkzieBEOs4yJhYAEb9xDqbjOU+5vathIyu3+KcScWByOudi/OIC/wHbW9Oxj3OGic7MfXyxALt2stQCvD3UqMQ9wI+dGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kR0vHOhXJlKoRUfERXNP8Cajv+YSIQuhc1x7OVadI8=;
 b=nNSco4LT7wRgKVEAKlYyAdKA1AgItvsyujWY7l8VDlQai6maMXn/k0IU806Z9poUQ5EY2cPaXEjtfOCBHOfjIP+9kp3rSDP2XUbNCXwGXndVAILTAG7toRW5ITTAHxt11qQo1GwmIZeclxNfTkjaBczqmDoHP1saqbj0/9KwVxs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 20:34:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Tue, 13 May 2025
 20:34:17 +0000
Message-ID: <82cf1c07-026b-470e-b093-018dcfced5aa@oracle.com>
Date: Wed, 14 May 2025 02:04:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Naman Jain <namjain@linux.microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20250512140432.2387503-1-namjain@linux.microsoft.com>
 <20250512140432.2387503-3-namjain@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250512140432.2387503-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BY5PR10MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 310a52c0-a13d-4140-4636-08dd925d8851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFNseHUveU1lc3RZNitpZ1BVd3Y1ZGFjUzNuNDRPY3lFeGNMT2t4eDAwREpW?=
 =?utf-8?B?L1dvMENvWTk1ajIrMkVCNWxBSWJCMTVDSVBoc1FOWUR0OHh1aWg2NzE1cnVx?=
 =?utf-8?B?K1h3NE5vZ24yT3V2Tjh4REdTaXRhbnI3UTJYckZNNnZGYWtVS2lmYVNJcjBr?=
 =?utf-8?B?alVHYUkzaXM1YmNSN0FxTEsveDVsam9yRWpJaUI4Vmp2K0I5d0tmMUNPWE9V?=
 =?utf-8?B?c3ljZmVYM0lNNisrcEhPM3IrM1VtMzRwZzg0UElHRlozWEtrQ1JPemg3d1Ar?=
 =?utf-8?B?WHBnU0c2SU8zVnA1MXVHT2VvOGZWTXBXRTUxbldlSy9GQ3lGMWVSNExZYzZR?=
 =?utf-8?B?M3pGN2RQMDJ0bDVSQzFTdk16b0JDRDd0Z1FFSzFnQXNxTENxTG54WFdIS1Bn?=
 =?utf-8?B?RXl2K0h4NVV3bFFaR1FtbWJJd2x1cWRZSWpIRmhETE93NEN6bkRxWWJldjBz?=
 =?utf-8?B?bkI4eTFFRExveUpEUGY4WXlabVNJd0FZWm5WWVJpTHU1dXYveGdvSVhoTG5q?=
 =?utf-8?B?aEdhcVBQZHYyTitHZzM0T0RmRDBORU43UE5WaEx3bStEYkxkaVBoUjNLZEFu?=
 =?utf-8?B?bjFISHdnYUJSMm1PdWhPMDF0Ny91R0J5b05ETFlacWVacFd3cC9rcWwzaGps?=
 =?utf-8?B?V3l2RFc2dThjcEgvQU9XRkhZUXdVbDI4eDdwT05OaU4yb1JtRDdKSXhGTVlW?=
 =?utf-8?B?T0NOcGNScTlNVnFTMDRPOHlkQVRsREhjNkZOL0FhdnNXem9uYWxYS0R0R3RP?=
 =?utf-8?B?V1QrczhWaFZCWHVFSDB1aVlIZjArLzcwU2FkVVpqYjh0UE9nbVI1VWswVnlL?=
 =?utf-8?B?WjNUUFNxYThrdS9ZeWhzS1FGNjUwTTZmeC9aeW16SjRrZlJFdHM0TkVVbDBs?=
 =?utf-8?B?cERMRndqKzd2cmtrbEFMeFdMVTJvSUJCMWRjUHpwYXBHWkQ5amwrUGExNlhj?=
 =?utf-8?B?OTRyQk41bW9MU21NUlczZHBoaFhWZFBaSEp2R2NRdGhaWFBuVmlFOWhwRXVI?=
 =?utf-8?B?V3FLa0U3UVk4UDcrRndTWGVKQTRsUHlDSXF3b3lxclZMbFpNQzZsUm5FL0cw?=
 =?utf-8?B?YnhDYThCaTg3anZ5b3pCQ0RlcjFQbU01dmQ1S3JuekI0YWJlNWM1cGcvUmNz?=
 =?utf-8?B?MXU1dlQ2eG90T2lWcXZaQUFiNWpVSlRXZmpzWjhIblROcm9pMHBhMGlVR08w?=
 =?utf-8?B?N0hFRlRSZ3hVM0VOZ3lpcWhZRkQzcnk5VC83OW1oZURYUWFTL1loYUZ6NmFu?=
 =?utf-8?B?dW5WTDUyVEVXSDFmNVRVL1ZtcmZKbUhlRm5EeUdaVkdoMTc4L0JKN0VrSnBK?=
 =?utf-8?B?NXg5cXhGb3AvTjRaVVBVTlc5KzhDNmF2QnVZelpTQ2FqbDBTNnNmWlcrbVI0?=
 =?utf-8?B?UUdaZVV4U2xlQVpqWjdTc3M1K3JUN1FKRW94aTlYUDdzVGNyU2xMVXlyaklP?=
 =?utf-8?B?YlVUTTR4OHpObnBXTEZtNmtlVXl2aVZQa0VYMkVqUWZ0WVQzeERVOTNmU2lB?=
 =?utf-8?B?QVBBZWtYTWp3QzZjdVN3Tk9xamNqTXp3NFEySmdDb0ppVk0wN1gxbm9CUEdU?=
 =?utf-8?B?ZWlUZjh6b2Nic0hoWmc0aTlKamtiWGZScFRWcEMxVnBKVWJ2bGRCVTJwL2tK?=
 =?utf-8?B?bkc1OE1peEJtbGFJbk52bm9wajZZTnFqMlVCRDNOT3JsSlhzdzY1dHRjWUhM?=
 =?utf-8?B?K3hTTVdUeldFM05KRXp1YlA5M0plUFJPaGJlcmEvdkVreVNwc3dLVnYremVE?=
 =?utf-8?B?WFZDN2NpOStWNDRmWGUzWWNrSFBKRTUrN3FBcDlTMCtJN2VvNXJtaXdjZWFV?=
 =?utf-8?B?Z2FLaWpKZFhVSURUbTgycENnajhncWJNM29KV1F3cFI0WHVHcjVrOXNqamxk?=
 =?utf-8?B?VUo5ekNYb1dUalp4SVNlS1UzVmlrbTljQlloVktuQ2dIRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEZNTXNqYjhpSEhFQlVHbDZxUW5QYkZ1dVRYY2U1SEs0aWJka240V0pnZ2sz?=
 =?utf-8?B?djFBS01wcllSVVYvaitZWHVLL2lIbm5xRW90SHg2eHpDRUNSRjUxZUFZbkU3?=
 =?utf-8?B?OUtqb3pGblpkaUJrU2RjV0luNE1URm9wTTA1Rk5lRGRIUUNtd1IvL0pHNDFF?=
 =?utf-8?B?dHJqajRpQkI1cS9aWU5mb0xRMVlMWWxhUFJVdS9aUGVrcnBYMktPVFZoQ2NC?=
 =?utf-8?B?dERoalRxZTZtS0JMTEVjanZMNDc5WWZOQXZVZ2s3M1k1bG5XVTV3YzArM2I4?=
 =?utf-8?B?UWlQTlF4RUo3TVVZVHNDd2VmL2FsYzNjbjFPR0pwcXJTd2p3a1BpeERmWFNG?=
 =?utf-8?B?OStubEEvOU5pNGgzaXFLbUVoZTJLdzlSeWg2OEhXT1ptZFFqa0o1RFNKQ29y?=
 =?utf-8?B?UFZXQ2tqRHF2MGxFVmxheEFuUDRUcG0xU09UaTZ2L3U5TTBvd3BuSnQ3dlJL?=
 =?utf-8?B?S25PY0VEaDh2cVZQVUZpSlZJTEtuNTRYNlU2QytzSmRuQmcrZ3lrL2VuT1R4?=
 =?utf-8?B?ZHNpbkRrL1VMNHdDaG1sT1E2aGxRU0NjbzFhV2JFZDlyb3dBZjduMEZTaEU5?=
 =?utf-8?B?ZjVTb0VUK2NmcUMwa1BPNkNMUlVOUElvNFEwdWFuZUR0SmljTWNsYXlNY1BG?=
 =?utf-8?B?VHp6cStnWnhYdGErdkY2aTduVUUyK0FPUlRJWFQxMmlmbWt0UFlsaTM5MXhW?=
 =?utf-8?B?aTRJdTVGTmNvc2h4VzNQdWVKejFRTG9oUW5KOWQxZkNyYW9PRDJQdEhDQVhM?=
 =?utf-8?B?bTd5VUhnbE9MMngwS2puYmhwanV2ZTlTck0wcUVra1ZCWmQ1UlV2Z0xGZDdi?=
 =?utf-8?B?RHhJbW1xWVU1ZlBSZW14ZmJNREl1SHNmc1BDeFp3ZjMwTEhNb2hqbnNkUzZ6?=
 =?utf-8?B?V0krcTd5RE80bjdZd1c2V0ROaURUMHR1Mm5uZHJkYjJTNnRmNVF2dEY2dXpC?=
 =?utf-8?B?aVoyamtzZXRCb2c0eVBwS3dTY05YLzJjUDNrY3hWMG00YXlFZktYTlBIMDFh?=
 =?utf-8?B?N1NkRGRrN3gvYTdQUm85cUlLQzY4UWZjcW9iOG9OYTkrVWlqOUhoQmNPUzA3?=
 =?utf-8?B?QzlCTTcrZG42bjFhNmQzNngvbG1uM1B2ak5jR2dBWXVuQzA0V3ZBSkRnWVpW?=
 =?utf-8?B?MGtCcXVSdTM5a1RsdFNLNHlxR0tONll6Rmk2a1FQZlExLzVCZWp6WWxKempZ?=
 =?utf-8?B?RmJJbldWWkRkenJUZS91UmZYakJkVWNMWFU4M1ErN2M4Rk1HWXVXUmRQOFQz?=
 =?utf-8?B?Sk93SWhrUkg3dlNXTkJvUVhCZU5XUWVlSUFpRkxCdDZPclVYenhWQ3NRZkdh?=
 =?utf-8?B?eWxZdENFTXZDTnlRV2pPckZXUjlCSFFIRytrU3o4Nk9QbFNKRTF4SER4KzlB?=
 =?utf-8?B?QzNhT0V3eUxtN2YzZzhWaGMrbi9OVDRVZHArT1k2TzdKL0lGcXZtS2JZYUJM?=
 =?utf-8?B?ZGYzc3FsWHVFNUk0cktueElGaGxEVWdzdHZtcEl1alZCK2RzZ0h2NHFxaGhn?=
 =?utf-8?B?d1Eyb0h6bDBFNERvRmlILzRGc21TQUd0a2dZWmE3NEdHZmQ2WjUrNUJhRzIy?=
 =?utf-8?B?Z2NBOVhrR3NuZXNuMC81aVBicDlUUStaU2hJVWtJN1dIb0czcWk2YUY1RHNH?=
 =?utf-8?B?VnRRYk54S3RIZVpZd2hnOWhlQXBPNU01emEyTXI4UldQbmttY0tVbUZJY1dO?=
 =?utf-8?B?Q0xTaHh3b24ra3pnMjdWb0pCODhuNitrS0IyamNGZEdhK2RJbFVlWmxRbmNY?=
 =?utf-8?B?eGhZZnNYU3dJVzlkMVhXd1hWczl3anFNSFgvTVMvZlcwcWlEZVhuYUNqT3lG?=
 =?utf-8?B?WW1RUWI4a0JCVXpGU1JVQ3NnendqNzdkTzB1dmtMSThtc1lmUFE2Q0o2bklN?=
 =?utf-8?B?NG5xUDZiRVVaSmgvU2phS3QvSWQ4LzZsdVN3emloblNLMEExaVNTRXFWOWdr?=
 =?utf-8?B?RFNDdVdOT3dzMlFsYXQxdkNScU9xbW04VGVLcnE0eDh1cTViUXY3MTNPQnR3?=
 =?utf-8?B?SGVlRjVCbk5zZGtmKzBCQnUyRkExYXUvbkhpSXFPZUFFeUIvcUJmZWxSeGdt?=
 =?utf-8?B?UFlLeHcyOVR3WDNvOENmUUxjK1ZzVVBBSTNTem1KZTJ3ZGpHU2NJbkg5eXd5?=
 =?utf-8?B?aTNWQ1lKT3htUUd3d1RnQytoK0ZGUEQ2blRWOFhSNE53TGhncWRIbTNLR0Mw?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ear1IvH0oUdiVTwyJca+CWpxY6n0afM7AaYkyB1Fhysn9sZZUYGkYJ1gUqD8OkIofvzbxxszHevAf4Woy4N2wzRW65TJ41SOGm4OWm+ESiTIUfIhGB8EGVIF/XturqHF5BUiW5HWtQ2rPigRG8TpypmgyEadorqpSaUER6Ry9Of9oAnnN6NzGMoF0oIjnU40v+6IYTCtOXceFUdFGt6SsW4sEhchWw2cXvI0x9IbyBMIP2v/UVA+aqELpwoo4w0kAyy3oIv1EQ3YY0ojWAWC+jx+cCWTPosvVN/jECEytJjDjZjdHd4OM9+RsjJ5Tu9MlFobq8QrTUawG5dDbHvuVnlMb580+efFKTWLiONYl3j/4iwFp1COJgmGaxrFq6BczxvKqlKAZNh2mGUPalxLY4WHnrvtrjmbVdxsx8xH6ksEhZ/2DP3WvYBRIYbgb26plnokbKMPRaSxK/ZBul1rA+Ycr1uMdsgbQ0ZCJJIfWd5qUIv5c6d2uXoC09ykpc1sVod4bhiftvvLRAFsfwdpSRHWxW6nTGVmFJoaKlsosQ7JOILne7qm69SGqDq+6XYr4/u/KpQy6Y2mWbnrgjI/DAyOp8Px2PfZgYOJ6xpT7i0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310a52c0-a13d-4140-4636-08dd925d8851
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 20:34:17.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeeKfQVFwkNO2JoKAynDENKkE+5lE6DtPHcUkIOzdeawjsM/8ZhzDLwFKZRcWVwFUCinL43F5z0nUzRvTfKNwSsXLGtn6jo2u4jz3ei9ol8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130195
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE5NCBTYWx0ZWRfX2bCilfQt443g 6q6Pmr56VKeEi06BwZsbn7KP6/vJ6yq07kyUaoTRFpEewSR3tfALLECXY3HhckfY230P8ZlW3ux ichicsd7zun4VBiD1eiYszoucJKELtCwz6UkkLoh5XefYNeXXygiveSjzRtFZJ5qYm1/pxqjozE
 aia3HvByVxBRIg6NUfwEac0lCbI48d2VZ/GbEgB51K1KLSv8b7zcwQ2Dqilw7x7R+JcDh0kuDH2 AVCan9xV1YkbDEqhglsLkDGppCUhuI/pm+Em+A1aHT9Im3Au3EcsE+79iUyzC/FULIj8NJZtoSl VPVj2P41b3pgXxhs45CeHPlE9NtJC/bI2HrXV5EqvXOsNUSx5028WjTC/35p4DVXa1RXv6t/Xzd
 wa6MgRXsGtxmk6a9L4GzPEV3HAHhZTxNAg2yvYzMXHFiKgxnqPbjRbIqcUUgaqp5lsVsqk2g
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6823ace5 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=StR9TcZnD61P4X_VhYkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: jcvT3taDOeDEHdezUUGHMmswoPbb1AyO
X-Proofpoint-ORIG-GUID: jcvT3taDOeDEHdezUUGHMmswoPbb1AyO


> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Roman Kisel <romank@linux.microsoft.com>
> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
> + *   Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/pfn_t.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/count_zeros.h>
> +#include <linux/eventfd.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +#include <asm/debugreg.h>
> +#include <asm/mshyperv.h>
> +#include <trace/events/ipi.h>
> +#include <uapi/asm/mtrr.h>
> +#include <uapi/linux/mshv.h>
> +#include <hyperv/hvhdk.h>
> +
> +#include "../../kernel/fpu/legacy.h"
> +#include "mshv.h"
> +#include "mshv_vtl.h"
> +#include "hyperv_vmbus.h"
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
> +
> +#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
> +#define MSHV_ENTRY_REASON_INTERRUPT          0x2
> +#define MSHV_ENTRY_REASON_INTERCEPT          0x3
> +
> +#define MAX_GUEST_MEM_SIZE	BIT_ULL(40)
> +#define MSHV_PG_OFF_CPU_MASK	0xFFFF
> +#define MSHV_REAL_OFF_SHIFT	16
> +#define MSHV_RUN_PAGE_OFFSET	0
> +#define MSHV_REG_PAGE_OFFSET	1
> +#define VTL2_VMBUS_SINT_INDEX	7
> +
> +static struct device *mem_dev;
> +
> +static struct tasklet_struct msg_dpc;
> +static wait_queue_head_t fd_wait_queue;
> +static bool has_message;
> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
> +static DEFINE_MUTEX(flag_lock);
> +static bool __read_mostly mshv_has_reg_page;
> +
> +struct mshv_vtl_hvcall_fd {
> +	u64 allow_bitmap[2 * PAGE_SIZE];
> +	bool allow_map_intialized;

typo allow_map_intialized -> allow_map_initialized

> +	/*
> +	 * Used to protect hvcall setup in IOCTLs
> +	 */
> +	struct mutex init_mutex;
> +	struct miscdevice *dev;
> +};
> +
> +struct mshv_vtl_poll_file {
> +	struct file *file;
> +	wait_queue_entry_t wait;
> +	wait_queue_head_t *wqh;
> +	poll_table pt;
> +	int cpu;
> +};
> +
[clip]
> +
> +static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
> +				 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
> +{
> +	int ret = 0;
> +	struct mshv_vtl_hvcall_setup hvcall_setup;
> +
> +	mutex_lock(&fd->init_mutex);
> +
> +	if (fd->allow_map_intialized) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall allow map has already been set, pid %d\n",
> +			current->pid);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
> +			   sizeof(struct mshv_vtl_hvcall_setup))) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +	if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}

is this valid case if hvcall_setup.bitmap_size == 0 ?

> +	if (copy_from_user(&fd->allow_bitmap,
> +			   (void __user *)hvcall_setup.allow_bitmap_ptr,
> +			   hvcall_setup.bitmap_size)) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
[clip]



Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks,
Alok


