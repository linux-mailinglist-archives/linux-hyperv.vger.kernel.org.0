Return-Path: <linux-hyperv+bounces-10894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAmEN9l6BmqFkAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10894-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 03:46:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8F548853
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 03:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43CF53021BD5
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D87282F1B;
	Fri, 15 May 2026 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y8gYIlM3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B6BW3mJu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12C29BD9A;
	Fri, 15 May 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809558; cv=fail; b=PwYCY1sT7tSBJpfCBI8xvuh7WrTM3heNo2HxtlUDj33G17FSbPxVdfgSUsx3HKjfJ0yPSgiEZwKjs0bnQkFp7JJQsKJaAB8Sdmr10JR5NbSY28f4TOWlRE7czf5dtuZgQdVLj7JQV0ce7yzr6jLKg26xub6UqRp+Kw8KkDBHvRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809558; c=relaxed/simple;
	bh=6dzS2ZBUKUQedj2re8MeOvjJdHh1TfV2Bxyku2A/Gq0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ui1xRmQbGSgt7893XxVXkuksjaXWC8gSjSnQqHFoJQCHA0tuOVaL2VnvQTXBkKiU98qxLWQu5yM2JI+u58+r59YH6W3SxLXgG0QfPRRJAiQvptk8T11xsS+xZTL5kkKklwsKIRinGNcAkUtfzHRBDTvRL509cTg5Mxit4EXRC6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y8gYIlM3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B6BW3mJu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F0VCbH1482803;
	Fri, 15 May 2026 01:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wkdi8PYOPV4vmSmyQf
	k+GOse0rP4UW2EybEoyTJt33Q=; b=Y8gYIlM3seEHKIAFfBPlYIDp50fLPKedSq
	QBbbB0N98JzLlYk2ue3Ux0EGNir0MvYHzJC+z+Cc+4eHXrOvXHJ+i/1SzYcV9RUr
	Go8F1SJzrInqoBqYUFDCvMPf/dGx8mV5k09w/f1fnVnkoQ0Y7Zxbla74Zg/qyKNn
	8RmZyoOFsbGTTFNkyLWi8FQvlSIzUEG+vRJd2jVayN8hy1v+9Mgbj+BzhtxU06sS
	WDt1GAwt3MZ4KNVCIDEBsjFCHPii00NNSizcMlgJb6vsGX7MLxkW9s3f0Ngwb/sO
	ZCxgVwRuNoQdyr3zW6vwQ/HV864Z3QXbEzLgv+5D0WbhqyW95N2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e5m1q0dn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 01:45:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64F1ie84031829;
	Fri, 15 May 2026 01:45:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e5kvxm96t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 01:45:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGbfV1LyCfLhZ3CYhKWC0elfNUS/yDkrfZdGRxQdA9KYpZK+sJQvP1NdKW7isrb3o6VmCJcixcZpKEdwmm13zAfq0MSlt/jKezW1UXmHlpw8NxXyQoudqLtPJV64ih459FaKjoVJitPxZJw8QHQ8TH/cxc1w2humZmUVEgstpd/aEqmYLTdOE60IDcWMkJGIzLupGXd1QpIRMbOxlFDy8YelzlWIa+Tt8TzljyjMoqyP52U2o/QBnxnEDS/Mm+QMGFj5ojw8yDbkb8PAgIwpzHY3GsV0s7196PwGrRwNFP3ngruuKUtWnoU1C5L9mcfFpiNCEDhM9tNg0XI5apP9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkdi8PYOPV4vmSmyQfk+GOse0rP4UW2EybEoyTJt33Q=;
 b=fLWmwI7/IgeMTRBDyB98PKZHLbbDYss6aR3npKataWOT7Gg+jV3GV/Qxdt+ZkNYNsO9l1oQfS//3bWmyNUSnO4cQdi9HAzk41YR1XvOOZ0m8Mh2biJbMLreuPeHxLTlawc4ExLyWKVB3prK0hJX+FL7KXlkYcnY+o9CJdKn51G2uezXKJzh2JzMUKuK89vObymBhiTCzUvFS0TU41n+o8MeWg+uIFLEP4R/aye3KBqEPqqSaldd17JCyWAMK0cQtVNzs4OXqyTQVYqPy58+JN5zO/7DZkNMS1oUdGBEeAPfy2iv2NGTQfYw2K9yJRah+0jj+xM77n6/uzrNSD8e/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkdi8PYOPV4vmSmyQfk+GOse0rP4UW2EybEoyTJt33Q=;
 b=B6BW3mJu7g7Tmm6NJG4+93XPktD+Dn5/lamy4bV6A1DyX4RGPmzlmdh7UEY2s3x2n34DUXg4Gjut36Z8SkCEnsB+Y9G6BvVTdNkxfNUMuFwESsH8U5Q/3I0plulxoTZ/NzViiBas41ADJgTAHoO4tHCE1hgms7oALScMlg88Qes=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BN0PR10MB5013.namprd10.prod.outlook.com (2603:10b6:408:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 01:45:40 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 01:45:40 +0000
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, longli@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        mhklinux@outlook.com
Subject: Re: [PATCH v2] scsi: storvsc: Replace symbolic permissions with octal
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260506004948.2172-1-shofiqtest@gmail.com> (Md Shofiqul Islam's
	message of "Wed, 6 May 2026 03:49:48 +0300")
Organization: Oracle Corporation
Message-ID: <yq1wlx58myt.fsf@ca-mkp.ca.oracle.com>
References: <20260506004948.2172-1-shofiqtest@gmail.com>
Date: Thu, 14 May 2026 21:45:39 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BN0PR10MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: a342988a-a1ca-414a-9755-08deb223ab82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xXyNvP8vMNV7O/Lork1c+B9bT+BLu0S+xL7xNJwUdfBnjviXwpO4tRup71VlkZZMEtJ+8y0oICdeWmfLPi1ITazhBnzx/+LScp+Si7KmOfVuv3SSWZCDSKrELbVzjSzLe7jLJIcFpSgqo4/RcemAY7+XkAIy5Vd12onkYkFpEVFDPL+GeQNuHjPTh2s9BC1+KtfQ4H/nx99EL3hXRWnqEy3/eI8pMwpRn5DFRyOhRvYhGNqrWdPlm7e3dLsUI4pGtffUPVJ0SmiGMW4t0PM99lLRggpJ0GMx/BMY1TScorpwEEon6DyhSAI9VIKqSuVnjrTjUdM9lSGKh5xITT1VnINrbQHm5oJLHjodRKezJ72KgHrsPuOx0jl+Oz2j2IvMZ11fSlrvCMhk4EExB7p7xXtdtT9etQmkoID5xDmgKuDgv2v9DErUZEURDhVzUODrfJs/cqkZheMwk5BY9X4wBy+Sewd6KxrdRroW8o15QTkE3EWa7CUnwvK+U0c5Zvf3DkYL7KJaRHLzkcBNV4ktEhF3HwuTWjJ0+kV8q1WQ1AFkWg+jJAflwgs+x1PpZR+Csx7WLwp9D5YuqiBuCQdAU8vhnS/LfBD9C6hV7g0c0KEREhxQdVeIc9q4VnsLWrMND6NIGyBucLoWI3EfZwafEiRxHw/MTv5ILqrUPyTo13oU6KmMzbesaq3my7dDknXW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5fQNuOnIAhZGeqsBDleoE8Y437r5WqjwDhRxI1C4rLUTyXbb0qJ6kkS4xgI?=
 =?us-ascii?Q?arm/0g27imVRXnkTRkbQkjN8UT4iQAzKnWVqA91z+V4tGcufGcGw941uQwx6?=
 =?us-ascii?Q?HiR1gMtZ2VGyQ5eGA0Vo0Iq1f/M1yHzqDzyi/4zDNYC6fHvGsK8PP5YE43Gv?=
 =?us-ascii?Q?/TTNC13hImJoQC/sL1u+5x6CkJt+uI2Y3tVXzB/onCUXnhAUoKJJnluxkSpk?=
 =?us-ascii?Q?tEwkjqAjJUs8S6THT36097kX6iJOw+9OfmXDNycTB90GB3KSw3ub1UM5gSWc?=
 =?us-ascii?Q?3OfuaKBD5fNLuv944+1RSJ790bIGoQMbtceqqEEOZsbNZcEngnA+Z2zCuPi3?=
 =?us-ascii?Q?R7CcFMDPkIkSdCrfgI87veZ1uUdMeUooPIxJmTYXCMJ5VYvgF5pvhXdUs6OB?=
 =?us-ascii?Q?U6TeiO/ohOBJ+GcnxVwopOeqDzkoH7H0YUFgB9VYwLgRVRiNHYNjlKi/pX7z?=
 =?us-ascii?Q?i9S3gcuNg+XEus8Jx8BsxU6ZxsO1wcdTPYsktpJU1SmW7Rb/qQckt66WQzas?=
 =?us-ascii?Q?yqrq69i3gu5Lokkigj6OvQeOVkBYz73zgOU8jmCz65m6ecTw6T/nzWAMfahx?=
 =?us-ascii?Q?c/h/1O00StruPK1KiBvuJmJxCQ/Zd6YYWGJtmYUEeR5k5H8EAOPSZ5NVWCrf?=
 =?us-ascii?Q?4OwhtoBHmXlpDj0ERIR7OdOhNdT7yjC5QprBnBCFkyaNesdmarGom+yVVa/n?=
 =?us-ascii?Q?EV9wOFNEbwCq+m86BGxqKjShp6nFz0aJvWGbDZXDfOjBQJRPEMW5PPMbNHmc?=
 =?us-ascii?Q?spn4DGTUChG940tr8+0pf3AyKjDtx3JRyDa6zvcUDzgQ8YvdtinLPczE//on?=
 =?us-ascii?Q?sJefxvUTCd+U31boEgoTPKMR8xnyjMnYKgumPYHSj9ufhK7Cnga/9GnJ3+Uz?=
 =?us-ascii?Q?Aa5ZwvQi7s8J5rnABHjLkv9Iw93xVHGGJKiAqoPYdDhEuF274HS/DxAoiA6f?=
 =?us-ascii?Q?7vC9Un3gidgiGcnW/wiKdVqEVfZx3Ex1brRudwLt0zjpeYoPBBbmkJS/a6+9?=
 =?us-ascii?Q?bspnQ84qCJujwFW+fAYFZBUZRcr5mhdzsaEnvYJfDMXlav7hCfB8cor+WVwe?=
 =?us-ascii?Q?jwJpdIW3YKVfNjdK24Z8B/A4jvzbXcSzvEuviTjz6tL8qAqLFzr9rmY0RCfy?=
 =?us-ascii?Q?mnwA6iH8c5AuSAWKxY/rxvN8Fw7o3YQ8CJivkczZkHUS4CMGZpCmzU4pDAw2?=
 =?us-ascii?Q?SGaWN47Ez8N+LOt6IAh95TnEIiYcAFZFHlYJR7sDJgap4HYAyfhuNpjQatF6?=
 =?us-ascii?Q?pY44kYYRHlL6Cu+FaJOGJYvGYADFKFmH8HMgN8WFlN6F48n6Jg9Ff/AF/5gj?=
 =?us-ascii?Q?lAOMokSn8rp2nD2o64o/g6RB893shJ48VRD42sm16Y6VLcFMSBP0Z0BVW6Lz?=
 =?us-ascii?Q?T+lOKcdl0zSjFBiiqZdVHMWQnvOn3BX8k5bWw5Z+cjfVW+ri9IZ7Dyle1t5H?=
 =?us-ascii?Q?mgZ2wlTlQ0hO+WAT+uMEcvsekXV73gu3DVJmMxvtQKcg0HZPXwQr4/hkGFsS?=
 =?us-ascii?Q?BQwxazrGkaRpV2wYjo3M0g7bN3Nwv0F5Q7GSbBl4hvEhZF4KAn5PzoDyVNeA?=
 =?us-ascii?Q?FL3Bxn8cfQRxiJq3pkOkZ1uYZ1NPJTda2cXlZFaXc9nrvTn4eZNcOLW/VQe6?=
 =?us-ascii?Q?T/O44uAsEEBdTeMJi5a8q1Frms9UOd1MyB6DxGQSppfdSWWTzWtCgsG0+BMW?=
 =?us-ascii?Q?gJbmF1yYZwB+8u6MlE5YZOyFwWeoIcoGGlLPj9PAG0U2ObXXelM8BZ3X+5pH?=
 =?us-ascii?Q?YNOpynL1zFvv7Bb4SUdyYdinOuWBQxs=3D?=
X-Exchange-RoutingPolicyChecked:
	uGeZLUHQqrxsHDz/hYTJNcDh/hmiJ7XB/x1MwfeJkkdu7FEqhkrlTR66pu0toqB7VHigcg0ATxojNUTTpRj8XJAbWQIoMxzZEqiqQjnIre4xkdK6HJ7X3TxBLO7Bkw6iJ5VNEfTNp8SmKH8l1pXrWiYzbili+TQyPkrWRgkj4gvZQL+fMYQCsPdtddvhJDbd2Ywv9brQpu0ofsVsnXBpGgdjKOrzaB7hThXPIRsnJTy2pbqttc3T24i37ncr8tuFnWR59IBUThskY2nGscSBEvsP9tfuEJNT4EzuNsvotx+q+CWKXH9gdFmwLs5sdcFhVakvevI6qUGh/uzo4FS5UA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p7faeidq7k82bn4RuRg1pA3inbimbIzVkox6C8UxdlD6RTYJw3mqhuvVOwjAiV1ieo/aKraIFt5AkUZqfDqD//x0sxJ/oi8eW2MG3s3P+q4N9eatWfnGu/IuTvLlBbPymsiu+e/00zIxjR7kcrT/ltlwFylipuiodc94Hih6ZvWoPi4bGuicfalFpIXXixrkezM/ShXggJmH+FZSuM1Mr8MZ9pQN/27hRh9TrIuMLKGOneWYkd6ro+uqgjGrV7cYssDTruJznHo/TBGLUAB2yFSszOekRli06jfmza91SWtNJRvkcrIat3IleZQ6WlmXdWYvedEvXIZfG6DMoL3UGFfShIwKv6QkYpeDLqMd2LBaoFrN62xD1wqa7XXaxEJS7+G2l0/ZKsefCnrlDLA3f3DdfKnFeMfrO6bcWqu+Dbv9ZngmB1H6IZDQ2xoAhg5cL9hB6jtHjbivvIB6r+hZId0GaEP4fVpI8oj6ah9Efab8asC05gsDMSzWdZD7Y14flAXC10GTiO8m4SF78Qp+zaBCtFmDtVBzTScIHgzkkNHwCJ79/lDNkrLhiREOKVO59KR+b3HLE8Jegyl/HbwqwiRqe6GGybAX8c0R5rWUmAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a342988a-a1ca-414a-9755-08deb223ab82
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 01:45:40.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fbTZG3O2kAZZKtBKG/z8/2EI4HwyXHzH5YPh78uMVVy2KPXVp0XQ9kss5BT6/7O2AoNS5DiCW8Qe4zmwuTi4eoqfr7wCUh4vbDMWGJB1b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=668 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605150015
X-Proofpoint-ORIG-GUID: xEK9JjOi6qM0VXEojKAq_fedwAF0L8Jq
X-Proofpoint-GUID: xEK9JjOi6qM0VXEojKAq_fedwAF0L8Jq
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a067aca b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=xB4PgKRHdaRRgBI2U4IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAxNCBTYWx0ZWRfX1U7m1P1ULYHM
 +4FfUi6mBFFZBErLoWBHGmuEoeXwRP8fzFx+PcUg0adLhx4Db0tNYBNNxaC+ZplH950O2YgLpQN
 mwGtdTArT5/DypOwSzE506guGBHuPzfS68TJNik1AP+rP9VZY8kX1lrC88NXHoFwTrWuTp1CQaO
 C6sw284sAJTmHg6pSkK5x22bFBWZpDtqljFs0MK++9AQB5iA2zQt6JyjftsbW5P/D+2jJyvVDLC
 5uG24vNQajSg3VrGDr5Zg0oydTM+jm4xG8rzISFACVqYr/BUkQ5a6RQKS1QzxO9jRCdhrNCKbvh
 aJXrxgMEUPKQaWHO8AsrPuvGmxOGyk2ZcsnIFzdO31yShmn/P+gy3fBLF/YojvuhcKRsHSw6XsR
 B0YgUj9lAPL/UHU/PCSyrvmIwAXjJekzbum/a03jyd7+UEWLCl9/w9vST462JMp45yvkBDQg5GH
 tYDX0p1qXSgwJJJeiQA==
X-Rspamd-Queue-Id: 8BA8F548853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10894-lists,linux-hyperv=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ca-mkp.ca.oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


> Symbolic permissions like S_IRUGO and S_IWUSR are not preferred by
> checkpatch. Replace with their octal equivalents:

Applied to 7.2/scsi-staging, thanks!

-- 
Martin K. Petersen

