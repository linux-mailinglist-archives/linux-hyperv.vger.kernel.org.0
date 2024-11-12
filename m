Return-Path: <linux-hyperv+bounces-3320-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABEE9C4D22
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 04:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDC31F20FC8
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 03:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09541205E05;
	Tue, 12 Nov 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fxDqS20b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010014.outbound.protection.outlook.com [52.103.7.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337520512A;
	Tue, 12 Nov 2024 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381234; cv=fail; b=EMpt+EIRa7yEvJodQ2ZiTar1mDQL073eLGTcAT1e2EIDw6R2p1BZbqsZ3lNucpKbfie1jl5na2bOQRfFAnlyAjnKoAO9723JldFkqFN05Ui7OQRoUS7PLQ8dm6GSaGNOzrtXbNS+8w98gmzJ2xuGtfu/7DZhxCcqBcB4HYGHiYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381234; c=relaxed/simple;
	bh=sni96VF1/ZFYJuuP3OjaaqDvrzn6FidLiBYEbZ1JTa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlQ1O9RYNbTiIgXwKw04CnOqYBdSgak8xzHJybIdnptAOK3d2MA+fz61sbnry+Iz0ZsiEFYLUFQRdnY4OvtEk/d11ymnWnhU+qTo3fm0N4rykoJsWbRZoTT2Smx2rfQyz74dbnuJIXNv/Vu1IdtDTUBQ2VAC7dGv+KNux+VD5jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fxDqS20b; arc=fail smtp.client-ip=52.103.7.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPuDFjctZwOh9xOiHSdtBWOHjsRtjkK70lpd4kC3Q4wtDbJTX6UQPz96f8AoYaTSfu8iMleUxmqHXsHq6Qha92NHu7HSgBPzcB/7IrecuRLWMI/q3dzq1+veA/e3TwIMh9rcrwSzO3rPg2RMz+GlMiCUlH+8hQNTplEHHp9PN4N3I/WqcXSEcGXBnp2QpxjcS7S+7500Wgncs0RY3zV8TYZ1Q1m/ImLP7dx4pOg2DtdxSbclPw8V8W0lQ6cKt9sTkflP86+/oo6OEnwtAwcKgMb1BAin2C9Z22envqrcHLErx4q5fh0iwkMvuQIXoaIaJShZv5pOxp30zWP0m/p1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyVI8BxQC1tFPKRvynDfYkXJkS3A7RO+zgxlnr77cgA=;
 b=hVHkYAY9yjJqDqDh9iKKWMN6sDn7ZWsB9dR1V/egQSfVz7rl7Rtx4mrSVFHGBsjldqs9GMmnZWd4zZ28UBFV8xtWTmVgOzHWQ1o08/onjHfaYcI+gZlLM7XU+3T2IocmYNkQ0umuflK3UA3X5mIctTGwLCV7drWTw3d0EEiFgAb5zetlWblUwuytJBINz57WMD8AmZApu0BWRsTzGzNbMX+z13MCswrhDmjGtcG6xxmRTgUl/FQguRGMR0Y8B1sBYJUITnBWMDjvhvwH8JKPfG3zOXVdVxt2dwlJMmEccqUQMWDrt67jdTHDGpc7zCrh0xm49K3rtotgQFdDfyBGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyVI8BxQC1tFPKRvynDfYkXJkS3A7RO+zgxlnr77cgA=;
 b=fxDqS20bSfd8OB0i5Qg2oy25x2L8JJe6Kal0UgU3NtmJlAsH/DJJ5z5CvN39uBvQFSBkSkh2+XRRomoub+y55N4Gdc6BFWCtQYuBXajj8BfMFQPzIXWvdnB2XRTGlhPCCPt+gNatB0p04qDczwZoEm4kSKLI3EUhLnghXPtircGHApzPX8UBtA54Om0eyXwSyGPTCQSA90mILc/em2nTNsPO2cwMwuxaJumVlqPIyHVu2XO/bXp2v0v1R47XTp0rYVKq38fCMnhZAJV9TegNxFXwrcXAfUsTiAzQlmZlWAmq0bvGaTlyWeQivmklXr1lglgjReR4nV0ckQgtp+kEvw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6557.namprd02.prod.outlook.com (2603:10b6:5:1be::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 03:13:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:13:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Starks
	<jostarks@microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
Thread-Topic: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
Thread-Index: AQHbKdjVc/uD1sxpKEWYetd8Cd2q47KhHRlQgAo/igCABkj7AIABTHig
Date: Tue, 12 Nov 2024 03:13:50 +0000
Message-ID:
 <SN6PR02MB4157BB5A5F5EDFAC24D594DED4592@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
 <20241029080147.52749-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157D7212FE3F0F50FAB0592D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4c9e670b-eb37-4bdb-adcf-a4ebbebcefab@linux.microsoft.com>
 <dc8f4e45-c89e-4e2d-82ac-58dd6e9c9884@linux.microsoft.com>
In-Reply-To: <dc8f4e45-c89e-4e2d-82ac-58dd6e9c9884@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6557:EE_
x-ms-office365-filtering-correlation-id: 22e768a3-829f-4f93-3919-08dd02c807f5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799006|8062599003|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?CVWd87PGCHYbpw7IHoXiI0qIIPG6iftSFtaZq2toMZpMr1NJpPbfQB4H+F?=
 =?iso-8859-1?Q?itRnEJX3LBGjJusY+/QEaOAgO5krLR1jfHeoEP5jUq/aoMu92DVAv+0dzt?=
 =?iso-8859-1?Q?WiacuJoogfIDTWjtC4m6twZNv5tQ6sbjTFQwLbuveDOzQJww50Bp3D1vwO?=
 =?iso-8859-1?Q?MOXNPXYT9HAMxyRNO5u85JBEBGdn/Grrjn58ZC1NPUHM6tqcqFd65vLPKt?=
 =?iso-8859-1?Q?L8Ozarmqp7EH+fh50xRsDbWfNfRr5zi7DahB4lX1GADyJDmAdaVA45+2r2?=
 =?iso-8859-1?Q?8YKlx8J/Xs20OoH7YPV3vf2OfHF05EERkMfWdc8atfkBAKwf1dWPErb8UO?=
 =?iso-8859-1?Q?HJgIXZszT8t1Q5QFg5A8InjgNfMYmM+RA/Qb0zx2OLM0sfg3WrNepOZ05P?=
 =?iso-8859-1?Q?f1TdvxUl/tSqyt+quD7c4pu3aB0LrIc1HWBHXmKjLvTAFydxvw30w2/eXK?=
 =?iso-8859-1?Q?6rrcqlPnhxxyOEhgl5/ppMZLPSLlXCqsKKmMoLH18PZegMiNDrTDjjIgY3?=
 =?iso-8859-1?Q?Yct/LthanjjYJUwMogolMOzCIZPYK0Z06VIH8vHyyNN4706U9tvtkXE1jV?=
 =?iso-8859-1?Q?QRbvGrL6JW4h+CdwMv233SL+s8tcp3AhR1ZmY+qLLKWA5xV/xTomIJ1O1y?=
 =?iso-8859-1?Q?HeMDV+ZqLL3zbHbk67GnMpJGmtIMi3PRaFnkZC4ge8PLI9T/7Vj56n2DY3?=
 =?iso-8859-1?Q?yB0nIetZ+emT/t2taUMkGs4rZSZoEfTFwX4nosGlzecATmuDqie7hvgM7J?=
 =?iso-8859-1?Q?SpRABPFzbVEimdCgnzoZuNc1Y1HsOPbmqeaqaozHhEkZU/lfGqu9e7evfM?=
 =?iso-8859-1?Q?DUx+JccgaTd/pUdbe0nElbwHcfotdtrvUFSNtlb1VkjAAOLKZzPR+rCOrA?=
 =?iso-8859-1?Q?TaTdwJ4q+Yb6ZeyfO+SKbfWivQ1IuBqot/N0dW75j2PIi7yoVQ+Ub5tiwP?=
 =?iso-8859-1?Q?4jMSVz78J7wNaHyZX4HucnQMrh/x1OmJiPhQMwqQJeXljeZJzdEP2GArlx?=
 =?iso-8859-1?Q?1RrRIA69viteyayuATUNotcBpO9RHT/5KXMTKnCSSOXRDybkF5Dfe989Nk?=
 =?iso-8859-1?Q?Cg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RUHsxGwszJ2vdQ3MV7Kz4FmEnDqNHMVm7MXWMFglKeTxCcsDjuvAxxywXZ?=
 =?iso-8859-1?Q?Snq/9GUkcSFVPKkebGmwCO9kkg8CzHhvGtF1m/ja8EMJmFblZyEC9g5eCA?=
 =?iso-8859-1?Q?3AeXkVGpk4idr6lnQtpzzqk5DOu/ZUWAS9b/GCfUrulETRZxRbIW8G+urd?=
 =?iso-8859-1?Q?9esPs00ZX2QrF/qpIr4djTFtcx5LPpYdmp9EaWFBsQw7WxpFODQ5yNCExf?=
 =?iso-8859-1?Q?T5fhfukxGyoa68tyPDzOVOEgGdH+16gGnF6ELyEOe90lAZeJFgamxLug4l?=
 =?iso-8859-1?Q?kUCRgPxrHVRPyu9EsYEK1LLj+xTV/ibK1/0hBgJ1E4C5RhL7b1EjlNwTCI?=
 =?iso-8859-1?Q?jJAsuYJgpaJoGhnIoGbSpq5zfJ4lvoQkWl1Wpk36AJ0unMIBD2iwQTzGBN?=
 =?iso-8859-1?Q?WITwuhlp+r2ssQ7/xWHyLwlOAzG6AcT9jmq63osTqPBkvtOfT0htRurEwL?=
 =?iso-8859-1?Q?xDyKM6tn8HfdVDljVrHHCGd/3uXFcwlWXFj0No2ZXHCR52S9oK8Ex8Hk1v?=
 =?iso-8859-1?Q?CZTejaUD923fQcP4XXd76KS/W3LC9bRkx0/+EHpahBjHeuNvZzEwIIE/rU?=
 =?iso-8859-1?Q?UMSEclkXO70qc+OJ6Q87oMolenaxZ/0L8W0T9QiRRxZf+YNO/pl44+tXv9?=
 =?iso-8859-1?Q?jMiuVcSAwgF7uDqbH9UtBe7KcvmkrYO5iwC5/reikRIhACeEiKwkTZLILc?=
 =?iso-8859-1?Q?doEK+eCz6tU3wmRpcNBv21xqapcmmktHt7SUgcSlwNBUx/Vgovvs0uu9RS?=
 =?iso-8859-1?Q?Njg34WFbr5xx/k8sk0BC142X/AAnFA2IoD/SY93bBlAqmCJjl7+e0zYNKS?=
 =?iso-8859-1?Q?dOHO2tJIQ9n88vP9/2pSCdAnuILtj3Ezj61gU+uYmAvlhHwYhxre1b/ljA?=
 =?iso-8859-1?Q?85UhB8ak5sfkQn3t+0Zxc4kFRFXlevzja1cOig8LgjKUhH34A9aO2r92sP?=
 =?iso-8859-1?Q?DYKdBfMUwo1wf864GY12QUMcczoa3mV8n6UbagRYnWkjKFwGuiyrPJcQmV?=
 =?iso-8859-1?Q?V8JfNTqVl82uBdR7nRQy/mG7CKYhzJtMwYj5w08Lgfl4B8E4se5xYlkS7N?=
 =?iso-8859-1?Q?IaJ2sHC9TlonSxyBxmjbYxr9okZ+n9xOF0Ma9QF45d7preozQBRn8sjUpJ?=
 =?iso-8859-1?Q?X7CFhHdomZ8AGnnyJuR05OPwGz3k3GY2H1oksGvFHBUas+2TpsqXMWUD4S?=
 =?iso-8859-1?Q?qZesPzivWj9FiYI0m1ReN4rSlv25Vc4cfbmPlg+XSMZhnJHNB8Vm888WR/?=
 =?iso-8859-1?Q?RgMVcnvivPBka9inTqh4NiAT24Oh93oL4LIcJx11Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e768a3-829f-4f93-3919-08dd02c807f5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 03:13:50.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6557

From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, November 10, 2=
024 9:44 PM
>=20
> On 11/7/2024 11:14 AM, Naman Jain wrote:
> >
> > On 11/1/2024 12:44 AM, Michael Kelley wrote:
> >> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October =
29, 2024 1:02 AM
> >>>

[snip]

> >>> @@ -2494,6 +2495,22 @@ static int vmbus_bus_resume(struct device *dev=
)
> >>>
> >>> =A0=A0=A0=A0=A0 vmbus_request_offers();
> >>>
> >>> +=A0=A0=A0 mutex_lock(&vmbus_connection.channel_mutex);
> >>> +=A0=A0=A0 list_for_each_entry(channel, &vmbus_connection.chn_list, l=
istentry) {
> >>> +=A0=A0=A0=A0=A0=A0=A0 if (channel->offermsg.child_relid !=3D INVALID=
_RELID)
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> >>> +
> >>> +=A0=A0=A0=A0=A0=A0=A0 /* hvsock channels are not expected to be pres=
ent. */
> >>> +=A0=A0=A0=A0=A0=A0=A0 if (is_hvsock_channel(channel))
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> >>> +
> >>> +=A0=A0=A0=A0=A0=A0=A0 pr_err("channel %pUl/%pUl not present after re=
sume.\n",
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &channel->offermsg.offer.if_type,
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &channel->offermsg.offer.if_instan=
ce);
> >>> +=A0=A0=A0=A0=A0=A0=A0 /* ToDo: Cleanup these channels here */
> >>> +=A0=A0=A0 }
> >>> +=A0=A0=A0 mutex_unlock(&vmbus_connection.channel_mutex);
> >>> +
> >>
> >> Dexuan and John have explained how in Azure VMs, there should not be
> >> any VFs assigned to the VM at the time of hibernation. So the above
> >> check for missing offers does not trigger an error message due to
> >> VF offers coming after the all-offers-received message.
> >>
> >> But what about the case of a VM running on a local Hyper-V? I'm not
> >> completely clear, but in that case I don't think any VFs are removed
> >> before the hibernation, especially for VM-initiated hibernation. It's
> >
> > I am not sure about this behavior. I have requested Dexuan offline
> > for a comment.
> >
> >> a reasonable scenario to later resume that same VM, with the same
> >> VF assigned to the VM. Because of the way current code counts
> >> the offers, vmbus_bus_resume() waits for the VF to be offered again,
> >> and all the channels get correct post-resume relids. But the changes
> >> in this patch set break that scenario. Since vmbus_bus_resume() now
> >> proceeds before the VF offer arrives, hv_pci_resume() calling
> >> vmbus_open() could use the pre-hibernation relid for the VF and break
> >> things. Certainly the "not present after resume" error message would
> >> be spurious.
> >>
> >> Maybe the focus here is Azure, and it's tolerable for the local Hyper-=
V
> >> case with a VF to not work pending later fixes. But I thought I'd call
> >> out the potential issue (assuming my thinking is correct).
> >>
> >> Michael
> >
> > IIUC, below scenarios can happen based on your comment-
> >
> > Case 1:
> > VF channel offer is received in time before hv_pci_resume() and there
> > are no problems.
> >
> > Case 2:
> > Resume proceeds just after getting ALLOFFERS_DELIVERED msg and a warnin=
g
> > is printed that this VF channel is not present after resume.
> > Then two scenarios can happen:
> >  =A0 Case 2.1:
> >  =A0 VF channel offer is received before hv_pci_resume() and things wor=
k
> >  =A0 fine. Warning printed is spurious.
> >  =A0 Case 2.2:
> >  =A0 VM channel offer is not received before hv_pci_resume() and relid =
is
> >  =A0 not yet restored by onoffer. This is a problem. Warning is printed=
 in
> >  =A0 this case for missing offer.
> >
> > I think it all depends on whether or not VFs are removed in local
> > HyperV VMs. I'll try to get this information. Thanks for pointing this
> > out.
> >
> > Regards,
> > Naman
> >
>=20
> Hi Michael,
> I discussed with Dexuan and we tried these scenarios. Here are the
> observations:
>=20
> For the two ways of host initiated hibernation:
>=20
> #1: Invoke-Hibernate $vm -Device (Uses the guest shutdown component)
> OR
> #2: Invoke-Hibernate $vm -ComputerSystem (Uses the RequestStateChange
> ability)

Question:  What Powershell module provides "Invoke-Hibernate"? It's not
present on my Windows 11 system that is running Hyper-V, and I can't
find any documentation about it on the web.  Or maybe Invoke-Hibernate
is a Powershell *script*?

>=20
> #1 does not remove the VF before sending the hibernate message to the VM
> via hv_utils, but #2 does.
>=20
> With both #1 and #2, during resume, the host offers the vPCI vmbus
> device before the vmbus_onoffers_delivered() is called. Whether or not
> VFs are removed doesn't matter here, because during resume the first
> fresh kernel always requests the VF device, meaning it has become a
> boot-time device when the 'old' kernel is resuming back. So the issue we
> are discussing will not happen in practice and the patch won't break
> things and won't print spurious warnings. If its OK, please let me know,
> I'll then proceed with v3.
>=20

Ah, this is interesting. I'm assuming these are the details:

1)  VM boots with the intent of resuming from hibernation (though
Hyper-V doesn't know about that intent)
2)  Original fresh kernel is loaded and begins initialization
3)  VMBus offers come in for boot-time devices, which excludes SR-IOV VFs.
4)  ALLOFFERS_DELIVERED message comes in
5)  The storvsc driver initializes for the virtual disks on the VM
6)  Kernel initialization code finds and reads the swap space to see if a
hibernation image is present. If so, it reads in the hibernation image.
7)  The suspend sequence is initiated (just like during hibernation)
to shutdown the VMBus devices and terminate the VMBus connection.
8)  Control is transferred to the previously read-in hibernation image
9)  The hibernation image runs the resume sequence, which
initiates a new VMBus connection and requests offers
10) VMBus offers come in for whatever VMBus devices were present
when Step 7 initiated the suspend sequence. If a VF device was present
at that time, an offer for that VF device will come in and will match up
with the VF that was present in the VM at the time of hibernation.
11) ALLOFFERS_DELIVERED message comes in again for the=20
newly initiated VMBus connection.

The netvsc driver gets initialized *after* step 4, but we don't know
exactly *when* relative to the storvsc driver. The netvsc driver must
tell Hyper-V that it can handle an SR-IOV VF, and the VF offer is sent
sometime after that. While this netvsc/VF sequence is happening, the
storvsc driver is reading the hibernation image from swap (Step 6).

I think the sequence you describe works when reading the
hibernation image from swap takes 10's of seconds, or even several
minutes in an Azure VM with a remote disk. That gives plenty
of time for the VF to get initialized and be fully present when Step 7
starts. But there's no *guarantee* that the VF is initialized by then.
It's also not clear to me what action by the guest causes Hyper-V to
treat the VF as "added to the VM" so that in Step 10 the VF offer is
sent before ALLOFFERS_DELIVERED.

The sequence you describe also happens in an Azure VM, even if
the VF is removed before hibernation. When the VF offer arrives
during Step 10, it doesn't match with any VFs that were in the VM
at the time of hibernation. It's treated as a new device, just like it
would be if the offer arrived after ALLOFFERS_DELIVERED.

But it seems like there's still the risk of having a fast swap disk
and a small hibernation image that can be read in a shorter amount
of time than it takes to initialize the VF to the point that Hyper-V
treats it as added to the VM. Without knowing what that point is,
it's hard to assess the likelihood of that happening. Or maybe there's
an interlock I'm not aware of that ensures Step 7 can't proceed
while the netvsc/VF sequence is in progress.

So maybe it's best to proceed with this patch, and deal with the
risk later when/if it becomes reality. I'm OK if you want to do
that. This has been an interesting discussion that I'll try to capture
in some high-level documentation about how Linux guests on
Hyper-V do hibernation!

Michael

