Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1372D24C589
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Aug 2020 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHTSbj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 14:31:39 -0400
Received: from mail-bn8nam12on2136.outbound.protection.outlook.com ([40.107.237.136]:62848
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727921AbgHTSbe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 14:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfrpaWKZW1QVsQQjvDiaXQ/nom8AVt5NHiOi31tAr5NEQH79AZpXpqV14S2ImDRehQN7M4Id9mcywQhc+sxwJVQEguzhGQ2/Jyne7weKJqA05eneDpJfokJLQGxXw3+w8UlWYqlWVxjTpdlAc0yQ5GRAXxFq9ngEy+sJFUtzp7WPWEcv7OkN21Sta9bJaeB24S3b8q4QYsb+UQRZlRkL5Mgas/Xlf9ticq8u5MdNKlwRoR5eGsNv+DDt5E81/AGuy+g2OWXMGg1CK53wyGZ4a7PFYg4xwUDvYlsdhy1FFhRKNdJpwNixkCH1NGkX1cd7HqLFSQQit6LNxkBxbKgszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8lO7aVaRA+GX5ti5Gz8gcr6FOb5iUtG0DVNcAEkCCs=;
 b=WUa8mXCFHBLMExWEjZiTBbUO9V3nqSizCRXrWUQZ5Nq1S67gnH1eK4PJ0rb0+zFM8KzYSSJ4d+5vOWX36glg1VDHwqOZqsqmPsjhsbkNXqPO/FJfYW05CCzk5+cJR8MRSCDhAZ6xoqm1ZR9Q8F8GpS4SJPlyGd8AxP16SVnrY4hR+0RWrACYUehBsOC6fUZSP5xZawYW28FiebAxpoF5Bp4Q8u3f23nSULRQsCFi+YZttSnlIR+ZgGqfMZx2tFWBy7i9WlAOcjc/JBfiwIDcHIZScFfJ82q337iuury+BO0L/Y5XnlxYWz0feUALlgCEX5bFZxSTUsWM8FUdAuuAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8lO7aVaRA+GX5ti5Gz8gcr6FOb5iUtG0DVNcAEkCCs=;
 b=Xz0DDxLrkMoMgn4RhjiGxAO+sXg3ATcKbjYspD0LYN6ecNjKZ9dvjBzhI+csHSWaC33hqzKe6+Dvvij+K+kX92D/UfoTPN3UfbVRO5KvujEIkN7zY8ImH3apFz0yHEGcTyd/9kKSroaRWa4xItkShZhB+5Nb02zTM3tXZALP0dg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.6; Thu, 20 Aug
 2020 18:31:12 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%9]) with mapi id 15.20.3305.021; Thu, 20 Aug 2020
 18:31:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv_utils: drain the timesync packets on onchannelcallback
Thread-Topic: [PATCH] hv_utils: drain the timesync packets on
 onchannelcallback
Thread-Index: AQHWdlDtdkV2ehbVvUOPVvrqU48qR6lBUMDQ
Date:   Thu, 20 Aug 2020 18:31:12 +0000
Message-ID: <MW2PR2101MB1052254C5ED7C587E548DB3AD75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200819174740.47291-1-viremana@linux.microsoft.com>
In-Reply-To: <20200819174740.47291-1-viremana@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-20T18:31:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47ec43f2-3b04-4a47-bb93-e11bee28bb1e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e765de7-0e8c-4d02-02c0-08d84537376e
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB105061C41E80000D0910398AD75A0@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeFS0iPeRXL1guyrpuAG9HgEQYzzXAo8q12vpzyeByz67nqKFtb+kP5lPjHaE2abqtyZXanc3h9mpz7a3q8gmIBEWuCBA8tt/t+U4kQymLLEvveRQnyCqu6MZGXWhf89d5VPaVhOOa6ngh1J6xqgbLKpDUzlblicJR531pV4Oc7OKrg9blsnx1yVeOyNYiPj8FA5hGlR2UgbctelpdvXRSPaH++Vi+b6onUfxdSknbD5ybWSOjgr0P1T1kyAgc/8oZddDu/wrj0/45xZgoOxBbDsSIWP1O3lGbTcSZpT3akMwOrii2nRr1xe0Xbk8rX09Kx/8otTNav6NRV+a+FJhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(82960400001)(66446008)(54906003)(82950400001)(10290500003)(316002)(64756008)(83380400001)(8990500004)(66476007)(33656002)(66946007)(66556008)(110136005)(26005)(478600001)(186003)(2906002)(5660300002)(52536014)(86362001)(8676002)(55016002)(9686003)(76116006)(4326008)(6506007)(71200400001)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +1eZo3WOoGBJnazdTLAM+PXSh/s4c3UEdU9L5xlZGrO6/enouAAc4cRBgjm4Wb01VmB81LWXj8qZZzKMVrC6pLSOtaXgYR5UgGyabicwK8O6vpIaQVQL5J+d8Ibyx4LbnSrMbYMZg0LbpqAReMyaT2jpu19zch6kVtSEUSzpLMsyu/zxh6y0EzT37KkP4UuwElqVno3kJTEgUQ3N+rUQaz8Za3teeEjCbM8EkppdHtB9kixoLYc+64Nn0aW2Cxc2Dcamyd5aaq5/DxFMo8h4mAFOW/7HmJQEFHZPoMd/a/ru3QKBRAc2DYv1wGfCq6EnkpgFOVimMalZTfG4MbSpSD39tiK5mBF4h9RfiZgmtYJ5n/PUyPhIULPMTKIBFKLI93DxXdVhyo5rdBxKEuKFeJuvW4eu2yh1ybOhXOT88VfFBYgthTeYCiGYsFAdvKVAMsY1WKFu3yn1Ay3juQ2/SO+miNffeStILuaD9oroHRI/mdnus8j2+AYZjiDANONwGpg9B/P/cZXBulvZ2BwqDh9r9yd4WBNVnSeVIjRal9tsu0tHxE6jYTwmlfxyHbdtTypcTn3WLrp5qd79xTLHP4D/iSeB5uMIAPFLda3PESOK2VKFSyuGguEyAPNow2Pdpa5bDHfemIyMXyy8ojuHyQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e765de7-0e8c-4d02-02c0-08d84537376e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:31:12.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIkOwL8hcbgOiPsHAdtbKZp9sq07k9iL1v3NehT0EpnjGGIUkYOgWj6o9UiMybZGWaGn6osDfTrdR/M3H6JKDlABLQ/1DCmjp4PoCMccfIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com> Sent: Wednesday, August=
 19, 2020 10:48 AM
>=20
> There could be instances where a system stall prevents the timesync
> packaets to be consumed. And this might lead to more than one packet
> pending in the ring buffer. Current code empties one packet per callback
> and it might be a stale one. So drain all the packets from ring buffer
> on each callback.
>=20
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  drivers/hv/hv_util.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 1357861fd8ae..c0491b727fd5 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -387,10 +387,23 @@ static void timesync_onchannelcallback(void *contex=
t)
>  	struct ictimesync_ref_data *refdata;
>  	u8 *time_txf_buf =3D util_timesynch.recv_buffer;
>=20
> -	vmbus_recvpacket(channel, time_txf_buf,
> -			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
> +	/*
> +	 * Drain the ring buffer and use the last packet to update
> +	 * host_ts
> +	 */
> +	while (1) {
> +		int ret =3D vmbus_recvpacket(channel, time_txf_buf,
> +					   HV_HYP_PAGE_SIZE, &recvlen,
> +					   &requestid);
> +		if (ret) {
> +			pr_warn("TimeSync IC pkt recv failed (Err: %d)\n",
> +				ret);

Let's use pr_warn_once().

If there's a packet at the head of the ring buffer that specifies a bogus l=
ength,
we could take the error path.  But the bad packet stays at the head of the =
ring buffer,
so if we end up back here again, we'll spit out the same error message.  We
actually should not end up here again because Hyper-V shouldn't interrupt
when adding a packet to a non-empty ring buffer, but who knows what might
happen.

> +			break;
> +		}
> +
> +		if (!recvlen)
> +			break;
>=20
> -	if (recvlen > 0) {
>  		icmsghdrp =3D (struct icmsg_hdr *)&time_txf_buf[
>  				sizeof(struct vmbuspipe_hdr)];
>=20
> --
> 2.17.1

