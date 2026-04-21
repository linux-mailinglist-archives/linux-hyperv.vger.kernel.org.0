Return-Path: <linux-hyperv+bounces-10267-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Cl0WCZtW52md6wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10267-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 12:51:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA90C439C2F
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12C443010B74
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F73BADAE;
	Tue, 21 Apr 2026 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uGZLr+9/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011056.outbound.protection.outlook.com [52.103.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B5280CD5;
	Tue, 21 Apr 2026 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768663; cv=fail; b=TaBdDXLAWgnCfbrO8uOSpFpK+HPFml/PvhqqALNdqN/cyHxOSxXaq/4jYUp4HMyYPRXbkifR1FD0bdLQifKrOZHucUHAFj5eIjARxwlpchucSKKk3urGn4IxdenNfd6V19ZO1I37pCENK5a9Z7lqpp34FOuUHy2v3h4wmKzhw60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768663; c=relaxed/simple;
	bh=FGd2Uyie1qN1LuSzYNeg9NUGjzgCD6hO7qOT0owcAq0=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=WYjlXEX1+kcjAjbyE9gIkupyM1mZFtrXVymAHKHNI69uXLPZLoi7wK2eh3OLQqI7bEBQcBB8YoU7q0NmrznZ85T+AQRmDWzXbGS/4SyB/inTObYUbwtg05SK8xZK6Eje5uYwYGI7HdIk152iaB4sy5jCNNyXlrPXESiM0U6ccn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uGZLr+9/; arc=fail smtp.client-ip=52.103.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CShfDkyTIsmOQPBrl/DmMVB6ffJoCh2CjaVm3H7PBef33CpY9uuWBK3wldxmPD8ym1SZoOEO0+ngfJc8aja3VgNSbMABtyQb/JxpnhzLTCZZgH5ks3B8WpUIjtTXhDMV8ChYUelcYMCxb5Lh+nDCUKipBG8krpAzN1YxGTyw/q66sb0UjQMWiONABU+qsvqJ/EkeaiX0VKjMXdlowO475Bl5AGJ22olzRBtrKb7WWaUUDxnypNb9gbPYNrtrAX+XmQKEfetc1Kh21jrEDPE2uB48/RB2z4TEJ2Z4NI82hqTBngbkioYQR3WR+ofxo7Ylf4UN3W91fd1fKG98++ajAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sin29xOXdt3tIaILQL5SiYqKT743iBSYgL3PNohOGLk=;
 b=NqVuxjL0vx5FF1WVX76sLYCBY2ZrlRyuRxC8XgyhHmLPsAVxO1FXdBjp6JKZweW9/qnwktjeXUtlNKB1y0i3FpM/BgVCWiQ0knkWFRdkiUhZ1ITNyWZzts4JkFXkiTQ+WeRQLh5RbrzY5X+W2OKCToo89qArGolS4Gl1K3LLo+VIMJH9/8/LmNinVirjoB/eIdXQMugxXajdStbfZ3ZJ2/hPFsTkEIxNBzn0zuTGXlD8i+9rqrZxqkkOoU5yyvw1lSBOGtzm5O6dnHQ/tjrSVZV2F83ltZnO11RnMD+kf8p/z41CK4fkUb78NiqvTmF4wUwwRqTRRqmleLQ4ejrhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sin29xOXdt3tIaILQL5SiYqKT743iBSYgL3PNohOGLk=;
 b=uGZLr+9/vKx4/xlWFREwdyVPdr3dkbp3uPTRyCpqu94+tGA8+YWgeJjOvQeE2nMlQ6gxIbSGIPpFHFk8pyP/eDFQj/HnUAh8ndBMsgFHxlqrWbneo3OUa6h8Oif4f1+4++PatkIimSkOBYcd7HF8zyUDuq60FSLRZp/lLUxcI0U+3XRYPDLu7YE/Hzb55ihNzHraDnRjE8tGcmEtN/ZOXbY8Uy8VX0QqgtP5OHv2Sm0CoqQAOGvclJu08wIUzXj1O8w/FzcMDqpgCWhQ+JU+UIdC0qsbqMHUwJmI5stBFslf+c24SQiNsqiOyDNqwwiwYosHZPC1VQZMpK5LdpU2MA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB9004.ausprd01.prod.outlook.com (2603:10c6:10:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 10:50:54 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 10:50:54 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 21 Apr 2026 18:50:21 +0800
Subject: [PATCH] RDMA/mana_ib: validate rx_hash_key_len in
 mana_ib_create_qp_rss
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881D40E494BF61A4B298252AF2C2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAGxW52kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyND3bTMitRiXUsTA6MkyzRLo1SDNCWg2oKiVLAEUGl0bG0tAAgTZa5
 XAAAA
X-Change-ID: 20260421-fixes-9402b9f92e0f
To: Long Li <longli@microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=FGd2Uyie1qN1LuSzYNeg9NUGjzgCD6hO7qOT0owcAq0=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzOdhOSIn+o0UWxS2qfi9z92rwh06/1jt1Z/H9ywtb
 xQ3ef7B1qGjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJmKQzsjQ/2yx7pS4LfME
 jz2KvblHveDUa62A04ysW7OiLY+Jt929zPC/aOIh/fDXh1TXPXtwerv94SVFvQ1Rq3ylJm3lFbn
 8dG43GwDpbU2F
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::26) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260421-fixes-v1-1-518de9f25c63@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a8a7ae-5439-490c-3e4d-08de9f93dc06
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|51005399006|19110799012|22091999003|24121999003|8060799015|6090799003|5072599009|5062599005|15080799012|41001999006|461199028|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmZNcjNlRCtZMmkvOE9tMURvakF4ZFRxQ2JQS1lSTHdmN2FPcEk1S1hyM2hW?=
 =?utf-8?B?c3dRa3dxRzBOQUFRNGxpR1hMUFdmWmtBcGdYRnpRb1hjdW9XbnIwUk9tL1Iz?=
 =?utf-8?B?TUhZeU5KaUpCS0YwNU0zU09IaERjL3ZjYW9NTEVrbm43MHBMOW9aRXVCdnRu?=
 =?utf-8?B?ZXdIajZUaVg0Y3kyZHJnRHNSQkt1OFlQejJ2SXlHV0Noblp3OTlDZUtQNGRB?=
 =?utf-8?B?TzMyMjhkRFphYWtpN1g5UXRZS1k1WUxkVjNoOUpLTUZnT0FRdnF2TjNOUFlB?=
 =?utf-8?B?NVF4Wk11Um9BTTFFNmM1SVZsV3JsVkJ1eGNiSWhHMlhXT1M4N3pBWW4zejRn?=
 =?utf-8?B?cWpObTU5SVM3djBERGk4cVJUTHBEcjRBT3JlUGtRMHFZS2g2SDEyNkFRaHlL?=
 =?utf-8?B?U2ZQUmR0KzVSbWsrWm5Fay9FbGhMV3htN1U1UkNMTk0vVE1PWGtNZlpnVG5a?=
 =?utf-8?B?cDFZTDV0VXVjRmdxY1RVdDlOVkdCV2l2REw3UW5tTFFVZU4rQ01adk1jMm1n?=
 =?utf-8?B?UUNyV1R1VTV4SjM3OFJIY3dpTlFtZ08wT0ZxQ2d4cFlZaGVWd3ZCUEFJQ3dS?=
 =?utf-8?B?bnpvSUxGbmtRS3JOa2xBNzBKTmZHcFVzazZ5cGFRL2VZNXM1ZmcvaWwxWFRP?=
 =?utf-8?B?YlRLUnNwaGhxM0w4MnZ6dStnSUgyNGFLdE9wam5QTnM5MTRIYWFkU1JrTUpC?=
 =?utf-8?B?QkdhR0cvNzBtNkk2LzVZVEc2UDViMlBhTjNHcTcrZ0QrYjE2d3FTYTdrdWND?=
 =?utf-8?B?c0MzeUNBTXp0WGtpanpIOHc1cjZHMnZrdXNVc3pLV01kTnpvdlRVSG9rZS80?=
 =?utf-8?B?ZFNpQzBnL1RBeVhyWks2Y1l6SUNCV0pXY01Rd25GdUJabUM5emNtcDRpS3Yr?=
 =?utf-8?B?eVhKMWtWUThrckhmOWxNeDIra3R3OTFMY08vM0M1MnRqZ0trTCtGT0dsUXZH?=
 =?utf-8?B?bUpJQmJOa0wxcFAvWVhRTGRKRysxRTc5dnZacEpma013MitBalZxekVJOFZt?=
 =?utf-8?B?bG5XcDFUUEZ6bFlyWXpHcVdMbmNRWXRZcFZwZzZuSlBqSmZxODJqeXZvMGFn?=
 =?utf-8?B?dS9Bd0pHV2l6UXF6YTBRM1FCNXV2ZkhRTFRxczAyWTJTdjkzQkFNeHlsaEdN?=
 =?utf-8?B?Q1RTcVJvaDJLV3VyWmYxNGZRU0dJVjJCdldDdEdCeThYS3hkVW1YRnJMdlo1?=
 =?utf-8?B?Mk9jZWk1MDVMSk0ybnk4UzNmZXNyYS9neVY2UEJ1d2kwdTRzOGxsYlRHN2xu?=
 =?utf-8?B?VjZjSXVFaTRDUTExLytjQkdTQWFwQXlNdjhGREZSc1dsR3BhbGhvRGt4Zm13?=
 =?utf-8?B?TUd3cWI5MERpNDdJZENpc1Rka2Nad0JuRjNZYzFobjg4OWd0NlpaTkJXYXF2?=
 =?utf-8?B?d3J1U0N0S1pKNGl6aUlTcE82Ly9oOXpZR0wxbkY3ZXZ3TFJQTCtqNnNsMEVT?=
 =?utf-8?B?dWRYSk9YY2Z3SGgxZGpXTmlvc3U5UlVQZEg0K1F3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGNzclVPc3JwWDl2aTFKeVlIeDltMFdOUGVIbnBnemJjYWlBeU5GbEpLV1I4?=
 =?utf-8?B?WGI5akhQQ0dwb1F1UkZlNlJFYnFwRkJ2YW9GVnFHVHFPSGNtaWZ3cjB1Rnlq?=
 =?utf-8?B?NmJyTC9iUnRJU0d3NjlyYzhYOUtEUmlqaDZRQnlQdVFvR2ZkUHpjS0szek9R?=
 =?utf-8?B?T2I5djRzTWRpV25aeHBxTm9RWE9ubkhMUnR5cDY2RkJYRThXNU82S3M0V1RR?=
 =?utf-8?B?VGhqMm5rNUp5ZWRQZDFtRGVaU0JrRHlmUFY1VjVST1FOdzRqQTE1ei9nL3dr?=
 =?utf-8?B?RGNQa2hXTnJSc0VxODdVYjAreDBhZElrV3AxWHF0czhPTVl4NmtJRlpNQURW?=
 =?utf-8?B?c0hTVWgvZmJwZzc3cUJFRy9PdE5hZE95VlNKUDFnbHgzblpqZUk3eWJ4ZmNL?=
 =?utf-8?B?UVVYWE94S2t3ZEthU09ueWxqZDZpaXZWQm1XeklsTDk5TDU5Q1c3dUpwUVRs?=
 =?utf-8?B?M00vL3pobTI1U3I4RGVjVUpkSjM4Rk1ZaEg0QUFoSEJFNmwyQXMwZE9BZ2Mw?=
 =?utf-8?B?cmRqTFkzUGhwUHIyTUxobW9kY01Vbm9LVUQ1dEROWVhvMTNIam8vVjBtU0RI?=
 =?utf-8?B?QXZJRm1wK1NWOWhENVN0OElyZ0lCa1hZM2xQTkhWSVZXNlpteFIrNE4rVG9a?=
 =?utf-8?B?NDJYTThSaUhLRytYdmNGaGVMUTJMRUtKWUJ1MWttYU56OVpaZ2x5VmFzS0dB?=
 =?utf-8?B?Tk5Bd0ZXYVNzVTlEQ3NKcmtlNlh2amdJUlZhRG9kQzE3YTFsSXdDQ2wvcGhs?=
 =?utf-8?B?L0VkOStkMy9jOW1tUC9SdnR5UmVma0IycmNsSys0N2N6c1JHYmtzbXBqM3h2?=
 =?utf-8?B?UFZPcU5uN0s1TEMrNDVtZmZTd256bkpRejl4ejVvYWN2SFd2R05JVEtWZEV6?=
 =?utf-8?B?YVhnVWRpeHJXVGFFbW9MTTVycVhya21rQ3VDaEhXVm5paURCMHdwNWhlcU9n?=
 =?utf-8?B?YjdPcnJvTzFVdm9tMHZ5eUtnbnZKTXIwMFE4MUZxR1VWTkFWZ3lQTXkvVldl?=
 =?utf-8?B?WGZJTkNGR3pEZFJ4eTBkRHhYQ21vRUk2YTlKdG9CSGFQQUpzaHdGcFJsTVVP?=
 =?utf-8?B?K05IMjBxS0hZK3ozTHpDK1NGTkhqTTB3Rnp5c01uRlFYSytqVTkzd2tQbDAv?=
 =?utf-8?B?U1oyVmdCNjhwckdiVndnYlV2dWpndTJBSVNLbitPV3R1Nm93NjVPNDBFNmcx?=
 =?utf-8?B?SVBVVEpRRm4raVFJVlhaN2pBWW8rT1JFK0dqbXo3Z2oyODl3V3A2azRTTXhx?=
 =?utf-8?B?Ulh3azQ2ZWFOUHR0UE5ZNzhrbkJzOGtiVGNiZzBiZCtmeGxIWTZyYkRjZXBZ?=
 =?utf-8?B?d0NkQlRGRGlmU1RVcTl1ZHdJWWFLcmFvc29PMkNQODZyNVYzVWJtNHd4MTdW?=
 =?utf-8?B?UWFWOUVXNDliSmoxRkU2RGgxcEgzVms0SExES2RkL2hWdkdzWG5kSFA5RVVD?=
 =?utf-8?B?ZDJEclhCb2ZjRlUyS3pKbTNmMy9MeXhHREM1alpaQmdiUE9HcjluT29ESTN0?=
 =?utf-8?B?MWpKN1dlREYrSzZRODFlL1RldVo4SE10VkZXSHE3SWlEdEZHNkV3eXkxSWha?=
 =?utf-8?B?Szh0RDZHU0FocDJ2U2tuRVZiSkpjNmpuR3dsTGtMMVpPd3pqTWdxcHV3bDlp?=
 =?utf-8?B?elRSTkxDdzFsTFlwd3F4cVU0YjM1VDZJUnluMHR6eVZ3OVRHYkZHTkNiWHJw?=
 =?utf-8?B?d2lzSWtSZURRTGF4TWd3V3hqSmJQWDZLQUFWVVpsMG9LcW9ZZVRsQzd4bXVx?=
 =?utf-8?B?eHo2OGF5cnY5aERtekNXTVlJNWV3OEU4czUrcWw1aHdYbDFJaFJYWWF4TDc3?=
 =?utf-8?B?WmlzNE1jYUtlTXA5YWFvNG55TFVaT1FmVFI2cTVvQVBZUzloQ3BmOW1MMVJE?=
 =?utf-8?Q?4R4cMN1DZKYlu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a8a7ae-5439-490c-3e4d-08de9f93dc06
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:50:53.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB9004
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10267-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: AA90C439C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mana_ib_create_qp_rss() passes the user-supplied ucmd.rx_hash_key_len
directly to mana_ib_cfg_vport_steering(), which uses it as the length
argument to memcpy(req->hashkey, rx_hash_key, rx_hash_key_len).

A value greater than MANA_HASH_KEY_SIZE leads to an out-of-bounds read
from the kernel stack and an out-of-bounds write past req->hashkey
within the kzalloc'd struct mana_cfg_rx_steer_req_v2.

Reject any rx_hash_key_len greater than MANA_HASH_KEY_SIZE.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/infiniband/hw/mana/qp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad37a..f5ab545cfd74 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -151,6 +151,13 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		return -EINVAL;
 	}
 
+	if (ucmd.rx_hash_key_len > MANA_HASH_KEY_SIZE) {
+		ibdev_dbg(&mdev->ib_dev,
+			  "RX Hash key length %u exceeds maximum %u\n",
+			  ucmd.rx_hash_key_len, MANA_HASH_KEY_SIZE);
+		return -EINVAL;
+	}
+
 	/* IB ports start with 1, MANA start with 0 */
 	port = ucmd.port;
 	ndev = mana_ib_get_netdev(pd->device, port);

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260421-fixes-9402b9f92e0f

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


