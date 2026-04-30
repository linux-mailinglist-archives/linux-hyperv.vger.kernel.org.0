Return-Path: <linux-hyperv+bounces-10527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPf0DcjU82ku7wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10527-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 00:16:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1EA4A8779
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D9823017BDD
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D428642B;
	Thu, 30 Apr 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dNSBCHdn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020134.outbound.protection.outlook.com [52.101.193.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADF7E0FF;
	Thu, 30 Apr 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777587389; cv=fail; b=LK32eiuEgZIAJKlJzdVJmuXY/Q8ih9Ytx8bLdI0UxGxccQfCK4GKSpBZ7U2jU3ny4dgD9UtBizyRRTnTfNGUdRsl39fWT/r/jhhU9tKEDboIp8SePTjF/i4nPyKODkps0o/2M1NIkyFta+/Qp0HzfC6UfJzZ8+SURpXDtaw80vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777587389; c=relaxed/simple;
	bh=BbpLPMC2CpeY9GOzNO1ZUy80i0wUTxO0xCZva5FFa4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ojg27L+0gewDsCuFXhdmNDG2a5uU+P3DnMZPH3HUslTvd6cY+6kgGbTMztk1Sg/O0mYwIPJldMu7lf8B/nGoNphhNW2eOi5/tB+nzrE1pK28ScEQV7LNfoomGqOj4ggvvji+3gXLfF+SppIXcdfQzR0mTXRKmEO7mF8o1xn8Rks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dNSBCHdn; arc=fail smtp.client-ip=52.101.193.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chaToBb1/PmBPyEZC2RZbMxpaPi3eNynssC/BzvRHpqE0EhgGTtBfMCz1jZ38jq7kOeAr4UY9ocDU11nzhi/nFpGr/3vYj4Lqb4t+odAgqtJeHoVIqZEj6L31RKo1voKKi0Cf99MI6uphYQvr3YKir5K8oYW6M6W5JJknWmA/Fkc6v1TT1tHxSOcTvO1KRK0lh0gyvGrFhueb2lJFAukKLk2m3646+dquBJjdtsP03LF+tVswJGt/jZralY7QEOfFMOywIraVjqpOupo7p6Ly7Ki/cFnzJ4DkFvE7aKivRLNBV2fSqW84b3YbfJUKRKWGT97KerKQaG7NyGIcQyx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C79Kr23pIlbpdL09A2GhohdhbdYQR7ZD1AN0WEtXHsQ=;
 b=UJTQktiuTiZfMqQrmasVeiTzvvZRr8LHnxUumWQhLfQhi+aeb68R/uFAAoLc8HiHFScyDTlTh+8vm5Im4ObeCCyd3gVl0M6ohcFLim/w/fDc0QJx7OCjmIljJGBJzXBl6KmKvjvyHWmicAVzVFqj3GV5bvpELxBPjduM9W0TjDCmb/dlUgp+nQBctSNa0T64kSzsOk4KdI9YkhSwICIGqMKAbofR3r08rsl3zhrWsqdOIurqtQLx6gEiQuZuN9vZCr6e6tyUwzHC0aMdeOWREwaneKdTRnJwdPXnGRDjT1IaBiqj4tiWZe/FS5Nh65AQk7z1ERKhYqyPky1ySr8nbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C79Kr23pIlbpdL09A2GhohdhbdYQR7ZD1AN0WEtXHsQ=;
 b=dNSBCHdn7+PkegeZc1EigwU5swZaSDP2orsQ49I9DCrGVMPOiViD4af2PmMRSZ5ouHTVgrBzvyka9CCQ1l6QbW2kJxr58P8FQlcm0zKspKbWCVvX5qYgkuyddJyuG8kLsNj3ilpAczum6HTcwd9o7wY/Q2App9lzuFgY3lMGBDI=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6178.namprd21.prod.outlook.com (2603:10b6:806:4aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.5; Thu, 30 Apr
 2026 22:16:24 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9891.004; Thu, 30 Apr 2026
 22:16:23 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
Thread-Topic: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHczc/fn1PdG2gkFEeUWQdp0QjV5bXs9OVggAhpmHCAAQocQIABxLfQ
Date: Thu, 30 Apr 2026 22:16:23 +0000
Message-ID:
 <SA1PR21MB6921C62009BE8DEE8019F0E2BF352@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260416183529.838321-1-decui@microsoft.com>
 <SN6PR02MB41576A849B6C4967622B4BA8D42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69214DC322549834104D26E0BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1534e24d-6f26-49f6-99ed-e15502cfd04a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-30T21:01:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6178:EE_
x-ms-office365-filtering-correlation-id: 58ac527a-9270-4503-496e-08dea7061d73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 KqBPKKmlyeVmRkLh36ZJ08GYC/0Oj7eFPMP3cqGiOhpoNyEEka7YiaPO2VN6MJG+kTm6Fvzft6noTSIYjiUi+G9wCQHslNDKmoDyTLQuY3HZrPmEH1a9qXkfxiNpS8m3ldYtOYhOr0O5Ciszmd7k7eQ73cZBZhKyruww3Twgv5zlEVv94jFTQBtgGHqGHVXVcK6coN9hJnKbHbcl8RqWZ/3ujxX6KTzWWVLdvler7Z/wJ/ttFIb/aTVcv/WNtoUUn6xSIhDy9A9IUlJQ+ZT3UL7mCmbNzOwAMpiRlgOg+IL2BHcB/wmjZVGEWIqU3MxY2zEOwMTRI8DCWezZzPaCgz1dCl7IztHLMFSwj1/t788EkWsalKgn1F8IBrEgZAejrnLL7SH99A05w+eA214gSzZf3rKgE43RGvbA6KgGhLa+hmL1hN4EsrkIk7tPl65mvasFAIvkWVxURin8XAdbTZof6XVz5M3Vun4Igsk1pqhvuXuQt7LLzn9LpdlGeQrtIIBc/46/BHSdOGq6MaygMd3Y4kKRK2pGLiUz8UyeNb/Yq71nSFDIb4mNic0vjZVwiJxsxyXrBGJ1pCutwiQLMHH1ahgz7KdvERT6zgO44kxFt4RVRFRgGkvdjwjzVEwxfREMm7UYM2P8lfhg74y2+qprfrweIFCnKhoh3dXDdYLTtZQQICIxbn/LahH17PXNOXS8R2r9byOInPZeGFm3T39YdL6AjssQ1K1oelhnUkdJ8pKkAwJBMBgP/NUU4FtE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nx/CSJnGJVtzWKHbFPtna6fmO4uvBSKKPKUntW2VgGnkAglXn5bRGOIwIV/z?=
 =?us-ascii?Q?0VuoBYmHn9VCFwXxyE4jErLCcy8o24QPPtHymzVVk6foNlrMV3BLehCrt3an?=
 =?us-ascii?Q?aEE4fodsFh0CY7lfZZzx+9p10y0gDC6rHjBYPwzOsZ1r0QrS34mAp8IKj15Y?=
 =?us-ascii?Q?M6NKkh7CdYQvmq5ZaZheGisYieuTPZzDrN74/LKfDEvfaHIMMhK4MKEz1Ee2?=
 =?us-ascii?Q?hmdfOSswc3GTGohLfrGW3GwuxZ3cZ27zFSG+lojaV2Es5+Ee3ngR/zLfFsO3?=
 =?us-ascii?Q?/xPPB8kG0DqVdE6g/cOcYl9I08gfNYDdyv0H8teUDO0SGFGvsWcdraJ9sDx6?=
 =?us-ascii?Q?i45NhJWidedJ4R1qkao+o7CU+T1T1q3Ug5yWh3k+cpeMf0oCkOtFnbu/0Kia?=
 =?us-ascii?Q?Z6SS/SjZe1mm2WkdcPPYGaL+IQdBMPeW8dx6YHCDK0TPmV/AvNXLIOiIBdxs?=
 =?us-ascii?Q?sf3jq7+v8Bqx8PM7wOkf7r+1dWLN6qONgPe2/+CY3PP8tqg6yvwAztZyZZ17?=
 =?us-ascii?Q?gOFnHvdlS8/RofjhP1NNMnOvONjqz1ZKfe8PweZS55lKi/udxd+Ni9ttyLle?=
 =?us-ascii?Q?wBSuGZz3UYw9UW2O9U4Mopex8QyzO+7sNBJhSokUoifWeD0G70COOGyIIlNE?=
 =?us-ascii?Q?p9LKnmUFlb1w1Pdx+ULiLWo3KbyLmI6QNi8+mXXzyUoW/8gZWvdsVhQNcwpU?=
 =?us-ascii?Q?gkXpRt6sxB4aqfSOlp1I5JBsgQBURI2EG8p0FH+YQER7u0GhnxI8PJmelOrq?=
 =?us-ascii?Q?AUnqcaaPseaYjPjbcmTUFIfu7BRdKOSvCMAmvObXGU374vb5EBaccnNY8KEn?=
 =?us-ascii?Q?lSXfejtlEgEHXXs2AA+5COsSkUUtfsq7b4Fnow0FZaK/wA/rOuWElFCaTC/g?=
 =?us-ascii?Q?gUFxsg4A+sg0XAoYwPhjVr6MlMTRlD2ra9mmndB7l46fIhVlrPy4MvYSHSqs?=
 =?us-ascii?Q?8RnKur6pOjMZiPGTMTiJg2OCyZOpS7EZcRd1KpL2/ywhNnZiykR6iOkzKVUi?=
 =?us-ascii?Q?ySjoIhwMEhlLSNMOO3+8j/jOvtp6XHBOL2yONuyrVHE7sQ3DXmPpZyXlv+Ew?=
 =?us-ascii?Q?LitL6C90kjNRygNgwhOQhVLg2MkbcYMxkGvLt16JWrdkdHhUM99aB32Yy2UE?=
 =?us-ascii?Q?klicryjtegRkKmnm0lTI9EHLof4BYoq8pttu+D8ykQ4tpf7y5GVCDOTvAII5?=
 =?us-ascii?Q?M5p05lHov5Y/kya95hJilBNIO84LJHWuwkxF37MnG1NMhSV+MTN3n1qPLbRf?=
 =?us-ascii?Q?JCGxI9z1E2ukV3iEZGw3t5kvnGsp+SPLz7BMe9HLvcnD2BTRRXHdnuiqdS8l?=
 =?us-ascii?Q?/NfC1+7bY/ZGB0BH15p35YD8vxQ7BSmIdJZ0nKi7eeGxjmgC1Dl3P5+cE4eW?=
 =?us-ascii?Q?1P5RtOAp5+nB8rhcSWtONamxnf1xKHExkbDNnMiHbCJilPUXnjaqXV8NyqIg?=
 =?us-ascii?Q?WVgaIvQmtEPQrqTQlT+R5eBhWhBdSfxCb/m3ktr7cXHNelCKYraQi7rm6sXg?=
 =?us-ascii?Q?9A34Jx8aOjIHsdAR8lvrCV+cDjNXRg93r/SVHaGds1dsgrT4Eai+J0vvan2O?=
 =?us-ascii?Q?IrftFFbejfgFsl1Wvt5xrYVr+PW3L465jTRfQneFaKPGUGOQ350sjUSaeVTn?=
 =?us-ascii?Q?frxyXDlTeA+LGk2BjPGROWvpWcTa6sKCiP56FDt2O12U/xHqNbB8Kjmx7spT?=
 =?us-ascii?Q?ShjeyhLamgBDHR3xy3kASL9wlCsf64YxrhXt/qzqqnmmRHrC?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ac527a-9270-4503-496e-08dea7061d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 22:16:23.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8ls1IpKRhSLEcLZCPgLE9RIS3GuDVjSc/06tc126Wt1Xg/fq9b/mhzFC4+feCGKJPQUJMMxkueBX9U0RDVOEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6178
X-Rspamd-Queue-Id: AD1EA4A8779
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10527-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org,canonical.com,templeofstupid.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, April 29, 2026 11:01 AM
>=20
> From: Dexuan Cui <DECUI@microsoft.com> Sent: Tuesday, April 28, 2026 8:13
> PM
>  ...
> >
> > A CVM on Hyper-V won't start without the command line
> >     Disable-VMConsoleSupport -VMName $vmName
This is not true. It turns out I can start a VBS/SNP/TDX without the
command line.... Sorry! Not sure why I had the wrong impression -- I
guess I was told to always run the command since day 1, so I subconsciously
thought a VM would not start without it. Or, maybe the host behavior
changed? but that seems unlikely to me.

> Unfortunately, on my laptop Hyper-V, a VM with VBS Isolation appears
> to *not* require Disable-VMConsoleSupport. I can start the VM, and the
> VM is offered the VMBus synthvid, mouse, and keyboard devices.
Actually I can also start a VBS VM without Disable-VMConsoleSupport.

> But what's weird in this case is that vmbus_reserved_fb() sees lfb_base
> and lfb_start as 0.=20
I see the same.

> Furthermore, as a test, I changed the "allowed_in_isolated"
> flag to true for the synthvid device, and the Hyper-V DRM driver loads an=
d
> initializes.=20
I also changed the flag .allowed_in_isolated to true for HV_SYNTHVID_GUID,
HV_KBD, and HV_MOUSE, but I can't see the devices in "lsvmbus".

In vmbus_onoffer(), I printed the offer->offer.if_type and
offer->offer.if_instance just after the message " Invalid offer %d from the=
 host
supporting isolation", and I indeed don't see the fb/mouse/keyboard devices=
.

I'm on a recent Hyper-V dev build. Maybe this is why my observation is
not exactly the same.

>In doing so, the vmconnect.exe window is resized larger, as is
> done in a normal VM. /proc/iomem shows that the DRM driver claimed
> the expected MMIO range at the start of low MMIO space. I can run a user
> space program that mmaps /dev/fb0 and writes pixels to the mmap'ed
> memory, and that succeeds as it would in a normal VM, but the
> vmconnect.exe window doesn't show anything. It appears that the Hyper-V
> host has allocated memory for the frame buffer, but is ignoring anything
> that is written to it.
>=20
> Running Disable-VMConsoleSupport works as expected -- the synthvid,
> mouse, and keyboard devices are no longer offered to the VM.

I even ran "Enable-VMConsoleSupport", which finished without any error,
but I still didn't see the keyboard/mouse/framebuffer devices.
=20
> So instead of not reserving any MMIO space for the framebuffer on
> CVMs, the code you already have limits the reservation to half of the
> MMIO space below 4 GB.=20
Correct.

> Won't that work to avoid exhausting the low
> MMIO space in a CVM that's running on a local Hyper-V with only 128
> MiB of low MMIO space?
Correct. I'll drop the CVM check in vmbus_reserve_fb() in v2.


