Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247392C7A98
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Nov 2020 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgK2Saq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Nov 2020 13:30:46 -0500
Received: from mail-mw2nam10on2120.outbound.protection.outlook.com ([40.107.94.120]:45698
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgK2Saq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Nov 2020 13:30:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJN036PiG0YwUMNjutKFGb3BjViZh8vjORC1QeGi7jyuwfcXkkfRoElx8NveaiHRCKZOV0LQ8mlEmwa3NTaFlLZXvr3tVrmFH9GOoXsbrxwskKLHJG3Rfld4f6jaOkBhVJpE6F1XEXLEb3kPHC4CTzG4JJqd6tbuBc1VsM59njmIw0T53qS1PBCXuzPnbBqMMAIRJPb3TeVH68b/rqS5Pi+ZeIfg6LEIQpZwEj6K7a+4Y8SdCNawoBamLOkVkQQAvUt9qydG7w6uVscxEhH0ju1FALNP/XF5xNyMHj8jFRTRmo4rcgIySF+tioPfUmcpS2RPRZ2d/GIaiOCqyxYA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S4v9hs3SvhDS17qhRJKRsjfFP6SJi8Fb0FfecYnQ8A=;
 b=S4fRK95FZId35vO98xkun59BNdFLPj7jd+RF8GY8NMxbkN4stHY9e1Soevhi0FLQi19Wgwh4atyjg+dezl6y0ApG6lMahudowdKLcUlbsRrCI3Cjgkr0cQVybn63oMYNRf32RbUssf3veLlsOP1dD0+sC4LiVSRs1cI2Qja90jYVG92AIaE+BibZw70UDcDLp2RImeTMwcxqlfoy3vNDPhUw9L50jxb3MADyLXzALmigmJspKN/+SveHCN35KJbHZMhyBha0344db8QEDB3cvN4+B4qhqQEihrYIJuSVZjzSW90ttvhHU80prXEc5ZxiRSjtSe9RcuX/BjawtBD1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S4v9hs3SvhDS17qhRJKRsjfFP6SJi8Fb0FfecYnQ8A=;
 b=Dm3N7VnBxYOKei95/nmMaC7ZrwUhLCjlMBXTTqRPeuZO0fQRXmODz85oKM5neX2RNz1ZiGbdf2X1cskm4eSS82Me2sF+lq+v/0TLShwBF2QkVPvX3Y+d8Pu3g05qVLoLPhrQfKRr6m0N9h4f23gunrueatf+NJ2zEKX/2kLIP4Y=
Received: from (2603:10b6:302:a::16) by
 MWHPR21MB0174.namprd21.prod.outlook.com (2603:10b6:300:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.2; Sun, 29 Nov 2020 18:29:56 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3632.010; Sun, 29 Nov 2020
 18:29:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL_RESPONSE message type
Thread-Topic: [PATCH] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL_RESPONSE message type
Thread-Index: AQHWxCge5mAOYMpwTUSy8GMfHlJLQ6nfZyXA
Date:   Sun, 29 Nov 2020 18:29:55 +0000
Message-ID: <MW2PR2101MB105279C034494D505E47EC15D7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201126191210.13115-1-parri.andrea@gmail.com>
In-Reply-To: <20201126191210.13115-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-29T18:29:53Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=338ae650-e553-4f72-beab-0e6231d7923c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63a11313-02c5-46f4-09cc-08d89494c545
x-ms-traffictypediagnostic: MWHPR21MB0174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB01745684D2EE8A8338B57F7FD7F61@MWHPR21MB0174.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ThesIdKX/5U1m6XRxpw/L9Ga6EnZmhn4cUcxkTu2aDfT5ansKXdvQcoJrqZdxXatS1KI9eddOftVmD8UT6xVOjavFAlJkSl1lSSzFWEwsrvwqkb1VzWtiS477QDf6jXf6S9TVacFKzo15AFwgZcSXAXIuk9w8xEzzDK/tDn7MxuUkHLPdpqQ80IQObON5ldONVHCaWkzatrV1/JgKMMOKNezuNVi1ChH4Wnmd2NoVQBjEKn0Z5mUWfg/xeibh/B6LuhxvitnVcB9bDNuHwcFegXcKyPfKdS4dbarnFyxKI1mRa0yapnEJ8pwzJztEi365eeTA7VZ02Z3s7IYkoOfLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(10290500003)(9686003)(15650500001)(86362001)(83380400001)(82960400001)(66556008)(478600001)(82950400001)(76116006)(64756008)(8676002)(66476007)(8936002)(66446008)(54906003)(110136005)(33656002)(66946007)(316002)(4326008)(8990500004)(6506007)(5660300002)(7696005)(71200400001)(55016002)(30864003)(52536014)(186003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vAANTNw1EshkOxbbjZCZW9guDetymgbWUDt+A4HN8uNoW3/4GwGMvLxBSpDJ?=
 =?us-ascii?Q?lJvEkXX88mHe8kFDsao5KH7zM7SlntxWOFMU3lMiNcO9xwUy2imGiQPaG5Ey?=
 =?us-ascii?Q?xIIF0NTcc5puBuAJ+0i8tSjrLiWSHJto24BE+jRQ0CWWbhwga8TuDaop5E6w?=
 =?us-ascii?Q?MYzeYW5pxgLlIMAYHmd98ACXz/xj9fiUscMpgnBQ5zBAdfJLRteTMQjbg9P5?=
 =?us-ascii?Q?qwdc0JY0lX+WXhH9++E7FRUMZek3sfZFhxn/duLETPmToX8MERGFqPyOsXPA?=
 =?us-ascii?Q?W2OwFpS+n2ccMQKVCUBZt4hTHyMD+BlwqfS+sJSeLvt/EtnIsaaUmRDgeDBP?=
 =?us-ascii?Q?GHzREfXSQEQYi0vnvOY6IXmKSO8yLmwrHkiImP1y8KMffamgJgQc+ZyqVeoF?=
 =?us-ascii?Q?YaRkIZvBRDBGaDYfwKx1aVT0vsLmp87GkiY9obZajO4YTTdaBlzTQC2tANUW?=
 =?us-ascii?Q?KGoHHJYcrUzknv+mCQ3cuIGu0nWxGHq8ug36M6perE/1ojgnd+Wx6Rcg4snE?=
 =?us-ascii?Q?rnR3/zgn2LACrpkRQoixgWTniaLUA65PLrcf3TZQwb2vRQE2yQ+ZKf7A283d?=
 =?us-ascii?Q?Ypsb0o1iaVo9cujsbFGLYLZOVqkjjRKfvJ3ZxBxw6MuPx+VmrSixYifTTafX?=
 =?us-ascii?Q?HWAbhjDha9UxpzZfR1DkktDXYCgzjjsheGOadAgqbURMxAekogGYe5RAHDk5?=
 =?us-ascii?Q?4jYK3jHXgFOmS5PmzNIkgydygkvWPoGKmXLo1w2bVh2oVnltWAl8MAAHRrax?=
 =?us-ascii?Q?dbeyITJSjg4/zyHANqogQ/FbfzjkjkrqrmNz6PFJcZkXFBgHbf9ptnpbOWU7?=
 =?us-ascii?Q?RtwT112JqFyOiDSM+n8aCYG2dq8Neo1kI5UFwaVcmOsLwpEuNznpLtUeRIhK?=
 =?us-ascii?Q?bpKq1KnK7RYHrhE9JiFN/GEXGM60iNjzMLPiXtxu+5pBn2Ljg7AFEEPWLWWo?=
 =?us-ascii?Q?hXB1UjfV6X04yg5qV4xO3s/jwvHmiXAJTTEJrPQ67AE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a11313-02c5-46f4-09cc-08d89494c545
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 18:29:55.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdpfiP4uOI41dKaggjaVU1wEJCS0WC9dne/3nMRRXtapkEUTO371KBPwSVkyPIqQVJQZoL4sCKElo6h6aQWJ3jcSfiE6C+XfBqeity65SPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0174
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Thursday, Nov=
ember 26, 2020 11:12 AM
>=20
> Quoting from commit 7527810573436f ("Drivers: hv: vmbus: Introduce
> the CHANNELMSG_MODIFYCHANNEL message type"),
>=20
>   "[...] Hyper-V can *not* currently ACK CHANNELMSG_MODIFYCHANNEL
>    messages with the promise that (after the ACK is sent) the
>    channel won't send any more interrupts to the "old" CPU.
>=20
>    The peculiarity of the CHANNELMSG_MODIFYCHANNEL messages is
>    problematic if the user want to take a CPU offline, since we
>    don't want to take a CPU offline (and, potentially, "lose"
>    channel interrupts on such CPU) if the host is still processing
>    a CHANNELMSG_MODIFYCHANNEL message associated to that CPU."
>=20
> Introduce the CHANNELMSG_MODIFYCHANNEL_RESPONSE(24) message type,
> which embodies the type of the CHANNELMSG_MODIFYCHANNEL ACK.

I feel like the commit message needs a bit more detail about the new
functionality that is added, including introducing the new VMbus protocol
version 5.3, and then waiting for the response message when running
with that protocol version of later.   Also, when taking a CPU offline, new
functionality ensures that there are no pending channel interrupts for
that CPU.

Could/should this patch be broken into multiple patches?

1)  Introduce and negotiate VMbus protocol version 5.3.   Note that just
negotiating version 5.3 should be safe because any ACK messages will
be cleanly ignored by the old code.
2)  Check for pending channel interrupts before taking a CPU offline.
Wouldn't this check be valid even with the existing code where there is no
ACK message?  The old code is, in effect, assuming that enough time has
passed such that the modify channel message has been processed.
3)  Code to wait for an ACK message, and code to receive and process an
ACK message.


>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      | 108 ++++++++++++++++++++++++++++++++------
>  drivers/hv/channel_mgmt.c |  42 +++++++++++++++
>  drivers/hv/connection.c   |   3 +-
>  drivers/hv/hv.c           |  52 ++++++++++++++++++
>  drivers/hv/hv_trace.h     |  15 ++++++
>  drivers/hv/vmbus_drv.c    |   4 +-
>  include/linux/hyperv.h    |  13 ++++-
>  7 files changed, 218 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index fbdda9938039a..6801d89a20051 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -209,31 +209,107 @@ int vmbus_send_tl_connect_request(const guid_t
> *shv_guest_servie_id,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_send_tl_connect_request);
>=20
> +static int send_modifychannel_without_ack(struct vmbus_channel *channel,=
 u32 target_vp)
> +{
> +	struct vmbus_channel_modifychannel msg;
> +	int ret;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.header.msgtype =3D CHANNELMSG_MODIFYCHANNEL;
> +	msg.child_relid =3D channel->offermsg.child_relid;
> +	msg.target_vp =3D target_vp;
> +
> +	ret =3D vmbus_post_msg(&msg, sizeof(msg), true);
> +	trace_vmbus_send_modifychannel(&msg, ret);
> +
> +	return ret;
> +}
> +
> +static int send_modifychannel_with_ack(struct vmbus_channel *channel, u3=
2 target_vp)
> +{
> +	struct vmbus_channel_modifychannel *msg;
> +	struct vmbus_channel_msginfo *info;
> +	unsigned long flags;
> +	int ret;
> +
> +	info =3D kzalloc(sizeof(struct vmbus_channel_msginfo) +
> +				sizeof(struct vmbus_channel_modifychannel),
> +		       GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	init_completion(&info->waitevent);
> +	info->waiting_channel =3D channel;
> +
> +	msg =3D (struct vmbus_channel_modifychannel *)info->msg;
> +	msg->header.msgtype =3D CHANNELMSG_MODIFYCHANNEL;
> +	msg->child_relid =3D channel->offermsg.child_relid;
> +	msg->target_vp =3D target_vp;
> +
> +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> +	list_add_tail(&info->msglistentry, &vmbus_connection.chn_msg_list);
> +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> +
> +	if (channel->rescind) {
> +		ret =3D -ENODEV;
> +		goto free_info;
> +	}

Does the above check really do anything?  Such checks are sprinkled through=
out
the VMbus code, and I've always questioned their efficacy.  The rescind fla=
g can
be set without holding the channel_mutex, so as soon as the above code test=
s
the flag, it seems like it could change.

> +
> +	ret =3D vmbus_post_msg(msg, sizeof(struct vmbus_channel_modifychannel),=
 true);

Use "sizeof(*msg)" instead?

> +	trace_vmbus_send_modifychannel(msg, ret);
> +	if (ret !=3D 0)
> +		goto clean_msglist;
> +
> +	/*
> +	 * Release channel_mutex; otherwise, vmbus_onoffer_rescind() could bloc=
k on
> +	 * the mutex and be unable to signal the completion.
> +	 */
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +	wait_for_completion(&info->waitevent);
> +	mutex_lock(&vmbus_connection.channel_mutex);

The calling function, target_cpu_store(), obtains the mutex to synchronize =
against
channel closure.  Does releasing the mutex here still ensure the needed syn=
chronization?
If so, some comments explaining why could be helpful.  I didn't try to reas=
on through it
all, so I'm not sure.

> +
> +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> +	list_del(&info->msglistentry);
> +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> +
> +	if (channel->rescind) {
> +		ret =3D -ENODEV;
> +		goto free_info;
> +	}

Again, I'm wondering if the above is actually useful.

> +
> +	if (info->response.modify_response.status) {

I'm thinking that current Hyper-V never sends a non-zero status.  But it's =
good
to check in case of future changes.  The implication is that a non-zero sta=
tus means
that the request to change the target CPU was not performed, correct?

> +		kfree(info);
> +		return -EAGAIN;
> +	}
> +
> +	kfree(info);
> +	return 0;
> +
> +clean_msglist:
> +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> +	list_del(&info->msglistentry);
> +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);

The error handling seems more complex than needed.  The "clean_msglist" lab=
el
is only called from one place, so the above code could go inline at that pl=
ace.

> +free_info:
> +	kfree(info);
> +	return ret;

More error handling:  The kfree(info) call is done in three different place=
s.  With
consistent use of the 'ret' local variable, only one place would be needed.

> +}
> +
>  /*
>   * Set/change the vCPU (@target_vp) the channel (@child_relid) will inte=
rrupt.
>   *
>   * CHANNELMSG_MODIFYCHANNEL messages are aynchronous.  Also, Hyper-V doe=
s not
> - * ACK such messages.  IOW we can't know when the host will stop interru=
pting
> - * the "old" vCPU and start interrupting the "new" vCPU for the given ch=
annel.
> + * ACK such messages before VERSION_WIN10_V5_3.  Without ACK, we can not=
 know
> + * when the host will stop interrupting the "old" vCPU and start interru=
pting
> + * the "new" vCPU for the given channel.

In the interest of clarity, make the above comment slightly more explicit: =
 When VMbus
version 5.3 or later is negotiated, Hyper-V always sends an ACK in response=
 to
CHANNELMSG_MODIFYCHANNEL.  For VMbus version 5.2 and earlier, it never send=
s an ACK.

>   *
>   * The CHANNELMSG_MODIFYCHANNEL message type is supported since VMBus ve=
rsion
>   * VERSION_WIN10_V4_1.
>   */
> -int vmbus_send_modifychannel(u32 child_relid, u32 target_vp)
> +int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_v=
p)
>  {
> -	struct vmbus_channel_modifychannel conn_msg;
> -	int ret;
> -
> -	memset(&conn_msg, 0, sizeof(conn_msg));
> -	conn_msg.header.msgtype =3D CHANNELMSG_MODIFYCHANNEL;
> -	conn_msg.child_relid =3D child_relid;
> -	conn_msg.target_vp =3D target_vp;
> -
> -	ret =3D vmbus_post_msg(&conn_msg, sizeof(conn_msg), true);
> -
> -	trace_vmbus_send_modifychannel(&conn_msg, ret);
> -
> -	return ret;
> +	if (vmbus_proto_version >=3D VERSION_WIN10_V5_3)
> +		return send_modifychannel_with_ack(channel, target_vp);
> +	return send_modifychannel_without_ack(channel, target_vp);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 1d44bb635bb84..8fcb66d623ba4 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1200,6 +1200,46 @@ static void vmbus_onopen_result(struct
> vmbus_channel_message_header *hdr)
>  	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
>  }
>=20
> +/*
> + * vmbus_onmodifychannel_response - Modify Channel response handler.
> + *
> + * This is invoked when we received a response to our channel modify req=
uest.
> + * Find the matching request, copy the response and signal the requestin=
g thread.
> + */
> +static void vmbus_onmodifychannel_response(struct vmbus_channel_message_=
header *hdr)
> +{
> +	struct vmbus_channel_modifychannel_response *response;
> +	struct vmbus_channel_msginfo *msginfo;
> +	unsigned long flags;
> +
> +	response =3D (struct vmbus_channel_modifychannel_response *)hdr;
> +
> +	trace_vmbus_onmodifychannel_response(response);
> +
> +	/*
> +	 * Find the modify msg, copy the response and signal/unblock the wait e=
vent.
> +	 */
> +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> +
> +	list_for_each_entry(msginfo, &vmbus_connection.chn_msg_list, msglistent=
ry) {
> +		struct vmbus_channel_message_header *responseheader =3D
> +				(struct vmbus_channel_message_header *)msginfo->msg;
> +
> +		if (responseheader->msgtype =3D=3D CHANNELMSG_MODIFYCHANNEL) {
> +			struct vmbus_channel_modifychannel *modifymsg;
> +
> +			modifymsg =3D (struct vmbus_channel_modifychannel *)msginfo->msg;
> +			if (modifymsg->child_relid =3D=3D response->child_relid) {
> +				memcpy(&msginfo->response.modify_response, response,
> +				       sizeof(struct vmbus_channel_modifychannel_response));

Use "sizeof(*response)" ?

> +				complete(&msginfo->waitevent);
> +				break;
> +			}
> +		}
> +	}
> +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> +}
> +
>  /*
>   * vmbus_ongpadl_created - GPADL created handler.
>   *
> @@ -1366,6 +1406,8 @@ channel_message_table[CHANNELMSG_COUNT] =3D {
>  	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL, 0},
>  	{ CHANNELMSG_MODIFYCHANNEL,		0, NULL, 0},
>  	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL, 0},
> +	{ CHANNELMSG_MODIFYCHANNEL_RESPONSE,	1,
> vmbus_onmodifychannel_response,
> +		sizeof(struct vmbus_channel_modifychannel_response)},
>  };
>=20
>  /*
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a5..cdf41c504d914 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
>   * Table of VMBus versions listed from newest to oldest.
>   */
>  static __u32 vmbus_versions[] =3D {
> +	VERSION_WIN10_V5_3,
>  	VERSION_WIN10_V5_2,
>  	VERSION_WIN10_V5_1,
>  	VERSION_WIN10_V5,
> @@ -60,7 +61,7 @@ static __u32 vmbus_versions[] =3D {
>   * Maximal VMBus protocol version guests can negotiate.  Useful to cap t=
he
>   * VMBus version for testing and debugging purpose.
>   */
> -static uint max_version =3D VERSION_WIN10_V5_2;
> +static uint max_version =3D VERSION_WIN10_V5_3;
>=20
>  module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 0cde10fe0e71f..35f240f4c833e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -16,6 +16,7 @@
>  #include <linux/version.h>
>  #include <linux/random.h>
>  #include <linux/clockchips.h>
> +#include <linux/delay.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -237,6 +238,40 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	hv_set_synic_state(sctrl.as_uint64);
>  }
>=20
> +#define HV_MAX_TRIES 3
> +/*
> + * Scan the event flags page of 'this' CPU looking for any bit that is s=
et.  If we find one
> + * bit set, then wait for a few milliseconds.  Repeat these steps for a =
maximum of 3 times.

A bit more comment here might be warranted.  If a bit is set, that means th=
ere is a
pending channel interrupt.  The expectation is that the normal interrupt ha=
ndling
mechanism will find and process the channel interrupt "very soon", and in t=
he process
clear the bit.   Since Hyper-V won't be setting any additional channel inte=
rrupt bits, we
should very soon reach a state where no bits are set.

> + * Return 'true', if there is still any set bit after this operation; 'f=
alse', otherwise.
> + */
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *event =3D
> +		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE=
_SINT;
> +	unsigned long *recv_int_page =3D event->flags;

I think a comment is warranted here.  The similar vmbus_chan_sched() code h=
as two ways
to get the recv_int_page, depending on the negotiated VMbus protocol versio=
n.  This code
assumes the "new" way to get the recv_int_page, which makes sense given tha=
t it is invoked
only for newer VMbus protocol versions.   But a note about that assumption =
would be a good
warning for future readers/coders.

> +	bool pending;
> +	u32 relid;
> +	int tries =3D 0;
> +
> +retry:
> +	pending =3D false;
> +	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> +		/* Special case - VMBus channel protocol messages */
> +		if (relid =3D=3D 0)
> +			continue;
> +		if (sync_test_bit(relid, recv_int_page)) {
> +			pending =3D true;
> +			break;

I'm not clear on why the above test is needed.  If the bit was found to be =
set
by for_each_set_bit(), that seems good enough to set pending=3Dtrue.

> +		}
> +	}
> +	if (pending && tries++ < HV_MAX_TRIES) {
> +		usleep_range(10000, 20000);
> +		goto retry;
> +	}
> +	return pending;
> +}
> +
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> @@ -276,6 +311,23 @@ int hv_synic_cleanup(unsigned int cpu)
>  	if (channel_found && vmbus_connection.conn_state =3D=3D CONNECTED)
>  		return -EBUSY;
>=20
> +	if (vmbus_proto_version >=3D VERSION_WIN10_V5_3) {
> +		/*
> +		 * channel_found =3D=3D false means that any channels that were previo=
usly
> +		 * assigned to the CPU have been reassigned elsewhere.  Since we have
> +		 * received a ModifyChannel ACK from Hyper-V for all such reassignment=
s,
> +		 * we know that Hyper-V won't set any new bits in the event flags page=
.
> +		 * However, there may be existing bits set in this page that have not
> +		 * been processed by vmbus_chan_sched().  We scan the event flags page
> +		 * looking for any bits that are set and waiting (with a timeout) for
> +		 * vmbus_chan_sched() to process such bits.  If bits are still set aft=
er
> +		 * this operation (and VMBus is connected), we fail the CPU offlining
> +		 * operation.
> +		 */
> +		if (hv_synic_event_pending() && vmbus_connection.conn_state =3D=3D
> CONNECTED)
> +			return -EBUSY;
> +	}
> +
>  	hv_stimer_legacy_cleanup(cpu);
>=20
>  	hv_synic_disable_regs(cpu);
> diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
> index 6063bb21bb137..3e83c24856dbe 100644
> --- a/drivers/hv/hv_trace.h
> +++ b/drivers/hv/hv_trace.h
> @@ -86,6 +86,21 @@ TRACE_EVENT(vmbus_onopen_result,
>  		    )
>  	);
>=20
> +TRACE_EVENT(vmbus_onmodifychannel_response,
> +	    TP_PROTO(const struct vmbus_channel_modifychannel_response *respons=
e),
> +	    TP_ARGS(response),
> +	    TP_STRUCT__entry(
> +		    __field(u32, child_relid)
> +		    __field(u32, status)
> +		    ),
> +	    TP_fast_assign(__entry->child_relid =3D response->child_relid;
> +			   __entry->status =3D response->status;
> +		    ),
> +	    TP_printk("child_relid 0x%x, status %d",
> +		      __entry->child_relid,  __entry->status
> +		    )
> +	);
> +
>  TRACE_EVENT(vmbus_ongpadl_created,
>  	    TP_PROTO(const struct vmbus_channel_gpadl_created *gpadlcreated),
>  	    TP_ARGS(gpadlcreated),
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4fad3e6745e53..3e1cd5e8f769e 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1767,13 +1767,15 @@ static ssize_t target_cpu_store(struct vmbus_chan=
nel *channel,
>  	if (target_cpu =3D=3D origin_cpu)
>  		goto cpu_store_unlock;
>=20
> -	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
> +	if (vmbus_send_modifychannel(channel,
>  				     hv_cpu_number_to_vp_number(target_cpu))) {
>  		ret =3D -EIO;
>  		goto cpu_store_unlock;
>  	}
>=20
>  	/*
> +	 * For version before VERSION_WIN10_V5_3, the following warning holds:
> +	 *
>  	 * Warning.  At this point, there is *no* guarantee that the host will
>  	 * have successfully processed the vmbus_send_modifychannel() request.
>  	 * See the header comment of vmbus_send_modifychannel() for more info.
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 1ce131f29f3b4..808acf4c3fe61 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
>   * 5 . 0  (Newer Windows 10)
>   * 5 . 1  (Windows 10 RS4)
>   * 5 . 2  (Windows Server 2019, RS5)
> + * 5 . 3  (Windows Server 2021) // FIXME: use proper version number/name
>   */
>=20
>  #define VERSION_WS2008  ((0 << 16) | (13))
> @@ -245,6 +246,7 @@ static inline u32 hv_get_avail_to_write_percent(
>  #define VERSION_WIN10_V5 ((5 << 16) | (0))
>  #define VERSION_WIN10_V5_1 ((5 << 16) | (1))
>  #define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> +#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
>=20
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> @@ -475,6 +477,7 @@ enum vmbus_channel_message_type {
>  	CHANNELMSG_TL_CONNECT_REQUEST		=3D 21,
>  	CHANNELMSG_MODIFYCHANNEL		=3D 22,
>  	CHANNELMSG_TL_CONNECT_RESULT		=3D 23,
> +	CHANNELMSG_MODIFYCHANNEL_RESPONSE	=3D 24,
>  	CHANNELMSG_COUNT
>  };
>=20
> @@ -588,6 +591,13 @@ struct vmbus_channel_open_result {
>  	u32 status;
>  } __packed;
>=20
> +/* Modify Channel Result parameters */
> +struct vmbus_channel_modifychannel_response {
> +	struct vmbus_channel_message_header header;
> +	u32 child_relid;
> +	u32 status;
> +} __packed;
> +
>  /* Close channel parameters; */
>  struct vmbus_channel_close_channel {
>  	struct vmbus_channel_message_header header;
> @@ -720,6 +730,7 @@ struct vmbus_channel_msginfo {
>  		struct vmbus_channel_gpadl_torndown gpadl_torndown;
>  		struct vmbus_channel_gpadl_created gpadl_created;
>  		struct vmbus_channel_version_response version_response;
> +		struct vmbus_channel_modifychannel_response modify_response;
>  	} response;
>=20
>  	u32 msgsize;
> @@ -1562,7 +1573,7 @@ extern __u32 vmbus_proto_version;
>=20
>  int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
>  				  const guid_t *shv_host_servie_id);
> -int vmbus_send_modifychannel(u32 child_relid, u32 target_vp);
> +int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_v=
p);
>  void vmbus_set_event(struct vmbus_channel *channel);
>=20
>  /* Get the start of the ring buffer. */
> --
> 2.25.1

