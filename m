Return-Path: <linux-hyperv+bounces-2923-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216BC966D89
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2024 02:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD131283270
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Aug 2024 00:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6233FE;
	Sat, 31 Aug 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aMHbg8Js"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF31D1309;
	Sat, 31 Aug 2024 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064487; cv=fail; b=f+RGH23IIiNpMBrguWiX9Tx28tfw7oqaWeE5YqYDEVk/GT+cTSnGJkyIYWM0PKRG0pWandqqXmhVSFSJn3ZWewEf5egfy7rNSDe5jAjqQsZdzy7ESvmhWtbXjMlutX8dvvvTgdq7Rr73VNPkQke9+qRLezHFP4pEqV5lnDIPkbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064487; c=relaxed/simple;
	bh=ZACvIu8C97mv3mIuxzlmFu2WMj9Fhh4/IGgMfKPjP9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmGkgbSWA8anauu0RDXPPNIBWqdnq6yMbxAzt0K69ymDwdbLXrBdOZaF7/fRlXPXJWSwuJV6+HxneKoigJT++TnFUgQUeCa08kXTeYlyMfCL3yYJEreTeOpKGpUC+go814tJrHciwV24YmQG6Rvg+/uIs3HjBVewIWcTdxn1nIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aMHbg8Js; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnICN+qw37MZSrpcCaox0pvUztHm/CRVTmnvsRD9UK7n1h3PE82+pVFzeZXdP1c9wYtAROhR2nKj5iOi0FdXbc+OaK/x8LgbN2XvdVa8cyCx+ZQ1TNWGE3Kun9sNsHLMUIMbw+mr26sgiyOar1NVtaazAE2z87n/UAlLnUWqqTmPPSp4PBt8A6AJLSur2t03RtxV+eFqBNFeekGVMCphOHe1jurxIc6worTqmA3rRKenUE28Os0rjja6KWimEhm3YWPstSyBrx4N8GPQxVQLnsD3F8uQbOsznMI3QdaF0NKy3jVzj5WSJLhbOZEGsLwnHL+cwAhQSaVJG5xIhtrEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMASVgHBiDJPyK3GXXT3weCnyKIL5KbxOl/CrNS4c+I=;
 b=PJ5JIjCqIUAGUsBrMsw1gwXrLNakZzbv9L1qaZAYgBpZCOw14OytAka9lXb+/kqyOFFiAH/IEDnDzLyKHfQxWruKsGI1P5YLXWxNo59oGHnQhupNzRnC3BGZjBPLQfiUa3j2srXiRAYeIqUtFVo3WDm0Hj3Ujkbso+68XooFzelBsC4B5swhhvNfjzo4snh4UHOyuJAfn/Kdqucfo8SPlKUT+ARYJjohEuooRijaX5x9S1bmzB8bgMnqfD7yBk1mQmvPwnF4APVu6guhmCFsmPKwH0TcnL95oa8UgWZDjpvSkM3YHD1ZTEZmjgvqXSwx423naVhvkmV/2vyOZxA74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMASVgHBiDJPyK3GXXT3weCnyKIL5KbxOl/CrNS4c+I=;
 b=aMHbg8JsB2d/N9WsVbnnopon4tp2Q6bBG47DFs9AVUG4qABa+Tg+XX1GRzp0sIfJ8SKz4IVPJYn7ASrCiY5Fpxh6t34+e7GD0+55z8Z5DoyEJ7sfkUYJEQbg6OfvIBxQ2d983tZfNEKA/3wHUwwDhH3NuvfGrcceu6V2zqdlgDc=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by LV3PR21MB4080.namprd21.prod.outlook.com (2603:10b6:408:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Sat, 31 Aug
 2024 00:34:43 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%4]) with mapi id 15.20.7939.007; Sat, 31 Aug 2024
 00:34:43 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, KY Srinivasan <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tools/hv: Add memory allocation check in
 hv_fcopy_start
Thread-Topic: [PATCH v2] tools/hv: Add memory allocation check in
 hv_fcopy_start
Thread-Index: AQHa+b1vG8hrFEeCykO1A3EareCyOLJAhOww
Date: Sat, 31 Aug 2024 00:34:43 +0000
Message-ID:
 <SA1PR21MB13179B929747B9B88948DCA5BF902@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240829024446.3041-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240829024446.3041-1-zhujun2@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=93a71bf1-2621-4514-bfc9-c0500b2c5759;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-31T00:24:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|LV3PR21MB4080:EE_
x-ms-office365-filtering-correlation-id: 53a3178f-a20e-437a-23c5-08dcc954b513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bo8kRs7rl3qKZnaqj2p2wUQnw2LTFp4VTxLei03dJg6W4hp5WyjmfoTfVwGA?=
 =?us-ascii?Q?+Kv2Q8KJAuLsNdbkdZB6eLrqR7PUqv0TXlC0TxQ8YHgURzGlxe5lxSgk+N1q?=
 =?us-ascii?Q?3uoASaF8eMWrozhEUEg2w44uOUZUHUFLgIhyj4gpYhEdmjlqfUSWrv7NO5ac?=
 =?us-ascii?Q?dwWaMqzULjiF/TLCdy+Ec4pOONZHZh8L4v8Yl3jHRXUiBR6+ELdDP2Qms6I0?=
 =?us-ascii?Q?9p15db1Rff+T4CzYR56Dhom1TQJObK4KkXnEVVfMQE2OUDQzHbWIg8ezw6M5?=
 =?us-ascii?Q?YqQJup4ecR6mDZqFRF91hmXU0v2iD6bugmp4zMZkuJ814tWesTIeQb/TTXli?=
 =?us-ascii?Q?jFIfXH52Fk6fytQRZm/QbYSsmlIOKyDBSoDYAg7NX3lfpzW8IYbILvgDgN0g?=
 =?us-ascii?Q?vLmrkuMWKeAL5FsK4BlMhmkigWXEYVJQPfBDEer4+JwPTWOxGEQnql8jNvAl?=
 =?us-ascii?Q?+NgAM5/YqnDSF4KT4Q0jbhBzRs9vYXX2jxVzyv0JkeKF6xkYgfwbeTnr498H?=
 =?us-ascii?Q?wRBHWf+Wi7v2UY6SA2rTMKkBqISYYwI7/d9Op8PGL9+BM2xcZQCH8odyc7RA?=
 =?us-ascii?Q?IRN8c3Oz/oOfD/hn7AmOT4EXijRyZkuTNww8yZyI6lrYkoA2kFCEUIP+dhCO?=
 =?us-ascii?Q?3gGuP7hUkowFHbc+t9l09JMmStyzz3irG8ylXvYLCJMYs7XcjFgnpx9Mp3Xt?=
 =?us-ascii?Q?rcexsuX/xLzo1JB9HQDjDBmf55dRK+gA2ZMizAmqKvTxT2Us+7ytJb6ejlTb?=
 =?us-ascii?Q?bWDkiDi1SMcM7yduD7XoBzKedFy1igejCKb4PM+JLaRZaPATv2DyncM5H14+?=
 =?us-ascii?Q?4XKAGegMDsFPj11p33T8RVnrQV5RDDx8eLCpX8GlDFQLCePjn40M0OxZ/MfW?=
 =?us-ascii?Q?Ado+V2VZk4+WiMM+OZTvFoyo+MPe6B5rJ4URzv5lTyud1A3wHDFLGW+VzeT3?=
 =?us-ascii?Q?yC1Cl/ONfhUctgNRFwSETE2KEJ75RwdO7lDeiQHzYJ3EAsqS/w72jb5ieRhb?=
 =?us-ascii?Q?lNqhxVhHdy4NxZMz/RbiRLE3NjO999byPFzY4kbHhKgA31X1ex1AqxmQ6m8F?=
 =?us-ascii?Q?aboJWLB2Q4r1ZXywWBiPWA/9IdgSwQM1TJHyAvLE5lJSb5kcPw17ZTtSwVQB?=
 =?us-ascii?Q?/eBRaLIWUf7U1bK2Z/Sebw6E5odFJv2KOYPI78MERW5xJ9DSjBiFgxT8BoSw?=
 =?us-ascii?Q?xUrN0NjGnA/5Xwj3GY6qJgSBMTrAI9yRVJI3kT9+VzXnBCfEnqrVEBzRizpY?=
 =?us-ascii?Q?kgyfGRoOkcGXFQJJsGO9SqGx2YXHWu+aXW3R77u/sfSE2AppU6QrDHX4KJI4?=
 =?us-ascii?Q?DTxvPD3ZNdzWOvwo9ZZvATbpdGqn+zItPOYDH8p1J4b1sJUSgctvRkTndutF?=
 =?us-ascii?Q?0rAUbE+ELkbsnUW6HdYdkAzrZ8NubPw3XyeTG+V6NQTOnX50Fw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?esP6RhtIocIld5VYuuBTyG4bBtqkHtNnlum6Nd7epNK7nUGbkEf6/FLk5SSf?=
 =?us-ascii?Q?VohqTMNHs2qAE9kreyy3fbTcSE+L3DmdaXDzNqFAHwMUsjYoXbvZohH8w50I?=
 =?us-ascii?Q?oxI1TcrELuwdccljtNFbGtOauyr6pplUHwU7I+mxYCsCkTo2x9LKU0GH25A5?=
 =?us-ascii?Q?Ba0Ycdmifs4ZNoEXwxDQAphKky0RUpCK0H7qTkJGkx94+qTKvIvBMYEFTaQJ?=
 =?us-ascii?Q?nsVS/YYMR9VlBI2zMLix1ADcWTztcNAECW/91ohLmDsnwHfpnGQxTag7fsjh?=
 =?us-ascii?Q?Koz5P8hmvsVRmB6HC++vQrbuA4G7L8mxJM9EWgA8lC/LiECQrhdLuuNBDKEm?=
 =?us-ascii?Q?L13TBBvgPgbu6Z301f4U6TxOJLOyUg2ERzCIRfrrVvy9HpvYa7+KHp2k0rpq?=
 =?us-ascii?Q?Pm6U6WDoQmcbZXnhMUOHNkmWjOFhFMXKPRZAAGrr3OSOzgGSKy2Gcn17s+YJ?=
 =?us-ascii?Q?gzst2X9tCIqJuLGWyFbxgXYrc4CmLZWHDzFmLzG8mrGh8fogWdL1/pbKNckQ?=
 =?us-ascii?Q?gVeqN/i+tCUTW/ekdZKCHqqi5VgP0veUfpJUi3wjExRXkMOPhTuywOwIyc5Z?=
 =?us-ascii?Q?7jGx5OOcxwyKQHB//TkaxolAvrCdoEc+xaR/0nWnVICt/15AYIEgqBtlcxxn?=
 =?us-ascii?Q?TZdBRb5veCuaCuDnQg4P+IKrrqHv+/WFiGDlY5kXbo3SWfz1Kq5sApVLfPY7?=
 =?us-ascii?Q?gXEq16q6gyhfKcp9v7gjH8F8mZ1BFiberJwbCgGW8A1MSlLnrvDBXTQ8pGki?=
 =?us-ascii?Q?mNNzSf+HIGSIJlzGaQiIsMWc4lPP7OAeezX1ZrGQ0PTztuwAgSJlDNKzGwgE?=
 =?us-ascii?Q?7GGXI25q01fr82AV5BQryt5XBupsrsSm48kJuiIHzwb91IHjr52y5+1yf3TL?=
 =?us-ascii?Q?9Q8dzhLNrj5PEavhg8623gcCCn5FJIifYXOGwmpmIO/1t1rwujGIvMYgb6JN?=
 =?us-ascii?Q?KSq6sgeO9EZr7sXvtA9I7PGfAt6MGCZ/h0GswnQ4qy4wmJuroCJYYXHaYdb7?=
 =?us-ascii?Q?YfrAr4oQMq0mAwWgyDnSKuRZNqsat7Ilv0MEL0WngukXNoUquaeReVpYIDnH?=
 =?us-ascii?Q?CnljBkcUSlFiBbm0c1bmuuG83SRIAxd4RZvZQ9jCVJfKmWkqL3tgdr0MxUcJ?=
 =?us-ascii?Q?AjbmnZlXme3mXYhg/PKKEf9Ah29kakL2JSv5zpAYcKrlozp0dWfYs74Lgmwc?=
 =?us-ascii?Q?OiWTpYeB54GRh46R43J5om2dk6jG2XtTQTWBUXWtkFiGn0uEPBMT/zCrUdZ2?=
 =?us-ascii?Q?C4+5zUZh6Gjwr/rrJ5o592I/2QjzRQaS2rQAVGJcKYU0rlsAysDtp/410k5X?=
 =?us-ascii?Q?KMxH0gNzOK8L6DCFP0SvKALmUCUG/KM3K69KBIeqQf7fU+3bgIanrbOJ0kEW?=
 =?us-ascii?Q?ErN7El0o1pr5rhdY0H4IGJvHdcJxVGOLlSd6gGq/hK57+uZN3Z/ejMKCavia?=
 =?us-ascii?Q?iuLq7qJcQwL0Yl5OeLXG/5I+ItKhrkj8+uNPADPksHpVS7bC7IOBRTLn20/s?=
 =?us-ascii?Q?BNRunxT/gOxv0cm9Bli4Rs7thTKQzLtz0XtIb1os9SF2AouRSusPXYJ/+K+l?=
 =?us-ascii?Q?OG0Gom8gZcMWr3RMLhPL4hq83Hebj6wXTbrJlkeLs7B1YYFJ6oOzHC0DW1Id?=
 =?us-ascii?Q?LmC07zkcgltuqHGmNqrz87E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a3178f-a20e-437a-23c5-08dcc954b513
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 00:34:43.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESBLct3Uq7a+r/4lMBobbgKZ8ydkM5EPasdscFpmU/36sg5eB495fQkcmGq+HIX3+dIPpvYGqHquywpgjKTFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4080

> From: Zhu Jun <zhujun2@cmss.chinamobile.com>
> Sent: Wednesday, August 28, 2024 7:45 PM
> @@ -296,6 +296,18 @@ static int hv_fcopy_start(struct hv_start_fcopy
> *smsg_in)
>         file_name =3D (char *)malloc(file_size * sizeof(char));
>         path_name =3D (char *)malloc(path_size * sizeof(char));
>=20
> +    if (!file_name) {
> +        free(file_name);
> +        syslog(LOG_ERR, "Can't allocate file_name memory!");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (!path_name) {
> +        free(path_name);
> +        syslog(LOG_ERR, "Can't allocate path_name memory!");
> +        exit(EXIT_FAILURE);
> +    }

If we're calling exit() just 2 lines later, it doesn't make a lot of sense
to call free().

How about this:

@@ -296,6 +296,12 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_=
in)
        file_name =3D (char *)malloc(file_size * sizeof(char));
        path_name =3D (char *)malloc(path_size * sizeof(char));

+       if (!file_name || !path_name) {
+               free(file_name);
+               free(path_name);
+ 	   syslog(LOG_ERR, "Can't allocate memory for file name and/or path name=
");
+               return HV_E_FAIL;
+       }

Note: free(NULL) is valid (refer to "man 3 free").

