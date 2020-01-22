Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E771145B8F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2020 19:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVS16 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jan 2020 13:27:58 -0500
Received: from mail-eopbgr770111.outbound.protection.outlook.com ([40.107.77.111]:51851
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgAVS16 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jan 2020 13:27:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0xxl52chmTECQg5A6PKeq699OWmR31ksIPHH222tp0c0GABdjQjuuhnFlq86OmTlEP6g4nRBLjpNBUMAvVLuTRcAv1pMYv79lv4dBzvcOjkUcs7DkI87472B7O5T/5PXRSj7OZK8XQfNF9f2E6/1h2gS7/5kL0jXm9f4YJmscGjVXCW1H6xOQs7TR/mWSlzorwvb0QHZi4LyCy/RGTkyGrd+SPYeegKZrbmsYNH+ThuIcNKnshT5qHPwaqYGLJ9rRZxShvydXc7SjwNHWQB3dGAMgtCug6xNGl8UnOz/LMW1xCmsOJGywUKIOZVqVrk/kF9CmfMNSEq+JdZZ6zWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4TImSyuLFO9TJfyO2q6xwlgouCrPsnuXWZIk9e/uY4=;
 b=nQZAr1nCAfadVgJQUf4mEajUWMxD5o0ySTGcIKQIYJGD4KguHTAQFW2p88K48PNGV9wuIIFa7ZtShyJS9AeaaqMZafxfZwHUL6fJ6oS5Nl3UePIT53sekqQ6eoZDnSYC9vof0HK6kW1u22NS6uezrmf3ADonBo9OxBmq73jmKsnEZQGOGzxQLp3ytI33fn+a16mKWb00CsXJrrpDYT1KaSH4nXbEwKpdtVDizp2kq4koykQ00XsTDS+QoQ4qub4DnWQAhDEwV0gHG96ZtgTewoFoMRFfpa0MjGPL3JTkQQNgerd5GwBkF7ZDsShtH6/M67a+bJbsy1UkSmp5cqKuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4TImSyuLFO9TJfyO2q6xwlgouCrPsnuXWZIk9e/uY4=;
 b=OxfUUle0UlUKksYqz0RtJ0nzuFFDKO87VSaDPbkQgOS+q2liK4+KA4g+ZbhgiIZxk5TgFGXlBMyESIHt+UrmbsWk42PQGLFk8yorq2dOnHPrksNboPKHOtG78XfqI0FsTuxn5aBGuGTuZXkZPn7DXwpL4NEYKCsDG3McyKsFodA=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) by
 DM5PR2101MB0869.namprd21.prod.outlook.com (10.167.110.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.10; Wed, 22 Jan 2020 18:27:54 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43%5]) with mapi id 15.20.2686.008; Wed, 22 Jan 2020
 18:27:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH v2 4/4] hv_utils: Add the support of hibernation
Thread-Index: AdXJ2zJbjzKVVIRATtCsfhHYStD+UQHcnlmw
Date:   Wed, 22 Jan 2020 18:27:53 +0000
Message-ID: <DM5PR2101MB104749677CD07DE42B5BD26DD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <HK0P153MB0148B7D12E62DD559A5D2B9DBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0148B7D12E62DD559A5D2B9DBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:32:21.2927925Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4db3c986-4f1e-4eb3-944c-2fd501d37986;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b39a0a7-0562-45b7-b4c8-08d79f68cbbc
x-ms-traffictypediagnostic: DM5PR2101MB0869:|DM5PR2101MB0869:|DM5PR2101MB0869:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0869AE261373692955BF8984D70C0@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(316002)(110136005)(81166006)(52536014)(478600001)(9686003)(81156014)(10290500003)(71200400001)(186003)(55016002)(76116006)(8676002)(30864003)(7696005)(2906002)(6506007)(26005)(66446008)(66946007)(66556008)(33656002)(8936002)(8990500004)(64756008)(66476007)(5660300002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1047.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7Brbx9Nzj/SXREY0rUFQWN0TsAulq8r1rSNnD1gpMj/Iro30poxbOKlrVVpCEadl5rtEhol2wQUcFkJOiK4iFibApWuf264+9B4KLM11VvBTf3mRhRhsWq4VoNmdpVfbrK9yjrNBk2xGwpIGxJBacZgsc9AjV4hRrE4Q96rWiqGhfj4QW16HWD0xcsb571elDakNTlYFh6aX24LGZjAawpg7eKWZl+HfetzAq6NSujWKY6P09bVsPheKeVPwpFNqxqRo7volMcM1iRWdBIz0D091Mu1RubHJA0Lygk4WlyRPhyensBvAFBEDOVEf5NTijbM5/ZB8E6NY5JqYjARVuqukeytLlmiX0kWAzw5COQpQr5RXKU+dtTg5HmE9c0jLWhlYySL57a3e/zj6RqyDq8oTo82j10R0TYS7DUofhVxXYBrR6PTqZHIIH1KpJT4
x-ms-exchange-antispam-messagedata: WiP2sypHJmI//XwRb1MdF6SpdZZBaawrJQVnjeAgl6d5NywDjm1ubgn6DTAXOlSfcTNt82z/hTk3n7DOoL81qKOFYcxngz+/brjQZANUu9iAe9tscDTRdiGbhLqpQ3q5a73UzI2ItXOTBgo1yiRsSA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b39a0a7-0562-45b7-b4c8-08d79f68cbbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 18:27:53.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7yn03+wc672qCUbyUaH3x6NN/+9JkV4/PzK7OJsjDj0WdhB6Q7HzxR1iMvY1wE5yX2d4JuP2uFadgS+kIS0bZAeu3KDuldZuV5ZxW8mrf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, January 12, 2020 10:32=
 PM
>=20
> Add util_pre_suspend() and util_pre_resume() for some hv_utils devices
> (e.g. kvp/vss/fcopy), because they need special handling before
> util_suspend() calls vmbus_close().
>=20
> For kvp, all the possible pending work items should be cancelled.
>=20
> For vss and fcopy, extra clean-up needs to be done, i.e. fake a THAW
> message for hv_vss_daemon and fake a CANCEL_FCOPY message for
> hv_fcopy_daemonemon, otherwise when the VM resums back, the daemons
> can end up in an inconsistent state (i.e. the file systems are
> frozen but will never be thawed; the file transmitted via fcopy
> may not be complete). Note: there is an extra patch for the daemons:
> "Tools: hv: Reopen the devices if read() or write() returns errors",
> because the hv_utils driver can not guarantee the whole transaction
> finishes completely once util_suspend() starts to run (at this time,
> all the userspace processes are frozen).
>=20
> util_probe() disables channel->callback_event to avoid the race with
> the the channel callback.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/hv_fcopy.c     | 58 ++++++++++++++++++++++++++++++++++++-
>  drivers/hv/hv_kvp.c       | 44 ++++++++++++++++++++++++++--
>  drivers/hv/hv_snapshot.c  | 60 +++++++++++++++++++++++++++++++++++++--
>  drivers/hv/hv_util.c      | 60 ++++++++++++++++++++++++++++++++++++++-
>  drivers/hv/hyperv_vmbus.h |  6 ++++
>  include/linux/hyperv.h    |  2 ++
>  6 files changed, 224 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
> index 08fa4a5de644..d63853f16356 100644
> --- a/drivers/hv/hv_fcopy.c
> +++ b/drivers/hv/hv_fcopy.c
> @@ -346,9 +346,65 @@ int hv_fcopy_init(struct hv_util_service *srv)
>  	return 0;
>  }
>=20
> +static void hv_fcopy_cancel_work(void)
> +{
> +	cancel_delayed_work_sync(&fcopy_timeout_work);
> +	cancel_work_sync(&fcopy_send_work);
> +}
> +
> +int hv_fcopy_pre_suspend(void)
> +{
> +	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
> +	struct hv_fcopy_hdr *fcopy_msg;
> +
> +	tasklet_disable(&channel->callback_event);
> +
> +	/*
> +	 * Fake a CANCEL_FCOPY message to the user space daemon in case the
> +	 * daemon is in the middle of copying some file. It doesn't matter if
> +	 * there is already a message pending to be delivered to the user
> +	 * space: we force fcopy_transaction.state to be HVUTIL_READY, so the
> +	 * user space daemon's write() will fail with -EINVAL (see
> +	 * fcopy_on_msg()), and the daemon will reset the device by closing and
> +	 * re-opening it.
> +	 */
> +	fcopy_msg =3D kzalloc(sizeof(*fcopy_msg), GFP_KERNEL);
> +	if (!fcopy_msg)
> +		goto err;
> +
> +	fcopy_msg->operation =3D CANCEL_FCOPY;
> +
> +	hv_fcopy_cancel_work();
> +
> +	/* We don't care about the return value. */
> +	hvutil_transport_send(hvt, fcopy_msg, sizeof(*fcopy_msg), NULL);
> +
> +	kfree(fcopy_msg);
> +
> +	fcopy_transaction.state =3D HVUTIL_READY;

Is the ordering correct here?  It seems like the fcopy daemon could receive
the cancel message and do the write before the state is forced to
HVUTIL_READY.

> +
> +	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
> +
> +	return 0;
> +err:
> +	tasklet_enable(&channel->callback_event);

A nit, but if you did the memory allocation first, you could return -ENOMEM
immediately on error and avoid the err: label and re-enabling the tasklet.

> +	return -ENOMEM;
> +}
> +
> +int hv_fcopy_pre_resume(void)
> +{
> +	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
> +
> +	tasklet_enable(&channel->callback_event);
> +
> +	return 0;
> +}
> +
>  void hv_fcopy_deinit(void)
>  {
>  	fcopy_transaction.state =3D HVUTIL_DEVICE_DYING;
> -	cancel_delayed_work_sync(&fcopy_timeout_work);
> +
> +	hv_fcopy_cancel_work();
> +
>  	hvutil_transport_destroy(hvt);
>  }
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index ae7c028dc5a8..ca03f68df5d0 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -758,11 +758,51 @@ hv_kvp_init(struct hv_util_service *srv)
>  	return 0;
>  }
>=20
> -void hv_kvp_deinit(void)
> +static void hv_kvp_cancel_work(void)
>  {
> -	kvp_transaction.state =3D HVUTIL_DEVICE_DYING;
>  	cancel_delayed_work_sync(&kvp_host_handshake_work);
>  	cancel_delayed_work_sync(&kvp_timeout_work);
>  	cancel_work_sync(&kvp_sendkey_work);
> +}
> +
> +int hv_kvp_pre_suspend(void)
> +{
> +	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
> +
> +	tasklet_disable(&channel->callback_event);
> +
> +	/*
> +	 * If there is a pending transtion, it's unnecessary to tell the host
> +	 * that the tranction will fail, becasue that is implied when
> +	 * util_suspend() calls vmbus_close() later.
> +	 */
> +	hv_kvp_cancel_work();
> +
> +	/*
> +	 * Forece the state to READY to handle the ICMSGTYPE_NEGOTIATE message
> +	 * later. The user space daemon may go out of order and its write()
> +	 * may get an EINVAL error: this doesn't matter since the daemon will
> +	 * reset the device by closing and re-opening the device.
> +	 */
> +	kvp_transaction.state =3D HVUTIL_READY;
> +
> +	return 0;
> +}
> +
> +int hv_kvp_pre_resume(void)
> +{
> +	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
> +
> +	tasklet_enable(&channel->callback_event);
> +
> +	return 0;
> +}
> +
> +void hv_kvp_deinit(void)
> +{
> +	kvp_transaction.state =3D HVUTIL_DEVICE_DYING;
> +
> +	hv_kvp_cancel_work();
> +
>  	hvutil_transport_destroy(hvt);
>  }
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 03b6454268b3..eb766ff8841b 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -229,6 +229,7 @@ static void vss_handle_request(struct work_struct *du=
mmy)
>  		vss_transaction.state =3D HVUTIL_HOSTMSG_RECEIVED;
>  		vss_send_op();
>  		return;
> +

Gratuitous blank line added?

>  	case VSS_OP_GET_DM_INFO:
>  		vss_transaction.msg->dm_info.flags =3D 0;
>  		break;
> @@ -379,10 +380,65 @@ hv_vss_init(struct hv_util_service *srv)
>  	return 0;
>  }
>=20
> -void hv_vss_deinit(void)
> +static void hv_vss_cancel_work(void)
>  {
> -	vss_transaction.state =3D HVUTIL_DEVICE_DYING;
>  	cancel_delayed_work_sync(&vss_timeout_work);
>  	cancel_work_sync(&vss_handle_request_work);
> +}
> +
> +int hv_vss_pre_suspend(void)
> +{
> +	struct vmbus_channel *channel =3D vss_transaction.recv_channel;
> +	struct hv_vss_msg *vss_msg;
> +
> +	tasklet_disable(&channel->callback_event);
> +
> +	/*
> +	 * Fake a THAW message for the user space daemon in case the daemon
> +	 * has frozen the file systems. It doesn't matter if there is already
> +	 * a message pending to be delivered to the user space: we force
> +	 * vss_transaction.state to be HVUTIL_READY, so the user space daemon's
> +	 * write() will fail with -EINVAL (see vss_on_msg()), and the daemon
> +	 * will reset the device by closing and re-opening it.
> +	 */
> +	vss_msg =3D kzalloc(sizeof(*vss_msg), GFP_KERNEL);
> +	if (!vss_msg)
> +		goto err;
> +
> +	vss_msg->vss_hdr.operation =3D VSS_OP_THAW;
> +
> +	/* Cancel any possible pending work. */
> +	hv_vss_cancel_work();
> +
> +	/* We don't care about the return value. */
> +	hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
> +
> +	kfree(vss_msg);
> +
> +	vss_transaction.state =3D HVUTIL_READY;

Same comment about the ordering.

> +
> +	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
> +
> +	return 0;
> +err:
> +	tasklet_enable(&channel->callback_event);
> +	return -ENOMEM;

Same comment about simplifying the error handling applies here.

> +}
> +
> +int hv_vss_pre_resume(void)
> +{
> +	struct vmbus_channel *channel =3D vss_transaction.recv_channel;
> +
> +	tasklet_enable(&channel->callback_event);
> +
> +	return 0;
> +}
> +
> +void hv_vss_deinit(void)
> +{
> +	vss_transaction.state =3D HVUTIL_DEVICE_DYING;
> +
> +	hv_vss_cancel_work();
> +
>  	hvutil_transport_destroy(hvt);
>  }
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index d5216af62788..255faa3d657c 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -123,12 +123,14 @@ static struct hv_util_service util_shutdown =3D {
>  };
>=20
>  static int hv_timesync_init(struct hv_util_service *srv);
> +static int hv_timesync_pre_suspend(void);
>  static void hv_timesync_deinit(void);
>=20
>  static void timesync_onchannelcallback(void *context);
>  static struct hv_util_service util_timesynch =3D {
>  	.util_cb =3D timesync_onchannelcallback,
>  	.util_init =3D hv_timesync_init,
> +	.util_pre_suspend =3D hv_timesync_pre_suspend,
>  	.util_deinit =3D hv_timesync_deinit,
>  };
>=20
> @@ -140,18 +142,24 @@ static struct hv_util_service util_heartbeat =3D {
>  static struct hv_util_service util_kvp =3D {
>  	.util_cb =3D hv_kvp_onchannelcallback,
>  	.util_init =3D hv_kvp_init,
> +	.util_pre_suspend =3D hv_kvp_pre_suspend,
> +	.util_pre_resume =3D hv_kvp_pre_resume,
>  	.util_deinit =3D hv_kvp_deinit,
>  };
>=20
>  static struct hv_util_service util_vss =3D {
>  	.util_cb =3D hv_vss_onchannelcallback,
>  	.util_init =3D hv_vss_init,
> +	.util_pre_suspend =3D hv_vss_pre_suspend,
> +	.util_pre_resume =3D hv_vss_pre_resume,
>  	.util_deinit =3D hv_vss_deinit,
>  };
>=20
>  static struct hv_util_service util_fcopy =3D {
>  	.util_cb =3D hv_fcopy_onchannelcallback,
>  	.util_init =3D hv_fcopy_init,
> +	.util_pre_suspend =3D hv_fcopy_pre_suspend,
> +	.util_pre_resume =3D hv_fcopy_pre_resume,
>  	.util_deinit =3D hv_fcopy_deinit,
>  };
>=20
> @@ -512,6 +520,41 @@ static int util_remove(struct hv_device *dev)
>  	return 0;
>  }
>=20
> +static int util_suspend(struct hv_device *dev)
> +{
> +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	if (srv->util_pre_suspend) {
> +		ret =3D srv->util_pre_suspend();
> +

Unneeded blank line?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	vmbus_close(dev->channel);
> +
> +	return 0;
> +}
> +
> +static int util_resume(struct hv_device *dev)
> +{
> +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	if (srv->util_pre_resume) {
> +		ret =3D srv->util_pre_resume();
> +

Unneeded blank line?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D vmbus_open(dev->channel, 4 * HV_HYP_PAGE_SIZE,
> +			 4 * HV_HYP_PAGE_SIZE, NULL, 0, srv->util_cb,
> +			 dev->channel);
> +	return ret;
> +}
> +
>  static const struct hv_vmbus_device_id id_table[] =3D {
>  	/* Shutdown guid */
>  	{ HV_SHUTDOWN_GUID,
> @@ -548,6 +591,8 @@ static  struct hv_driver util_drv =3D {
>  	.id_table =3D id_table,
>  	.probe =3D  util_probe,
>  	.remove =3D  util_remove,
> +	.suspend =3D util_suspend,
> +	.resume =3D  util_resume,
>  	.driver =3D {
>  		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>  	},
> @@ -617,11 +662,24 @@ static int hv_timesync_init(struct hv_util_service =
*srv)
>  	return 0;
>  }
>=20
> +static void hv_timesync_cancel_work(void)
> +{
> +	cancel_work_sync(&adj_time_work);
> +}
> +
> +static int hv_timesync_pre_suspend(void)
> +{
> +	hv_timesync_cancel_work();
> +
> +	return 0;
> +}
> +
>  static void hv_timesync_deinit(void)
>  {
>  	if (hv_ptp_clock)
>  		ptp_clock_unregister(hv_ptp_clock);
> -	cancel_work_sync(&adj_time_work);
> +
> +	hv_timesync_cancel_work();
>  }
>=20
>  static int __init init_hyperv_utils(void)
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 20edcfd3b96c..f5fa3b3c9baf 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -352,14 +352,20 @@ void vmbus_on_msg_dpc(unsigned long data);
>=20
>  int hv_kvp_init(struct hv_util_service *srv);
>  void hv_kvp_deinit(void);
> +int hv_kvp_pre_suspend(void);
> +int hv_kvp_pre_resume(void);
>  void hv_kvp_onchannelcallback(void *context);
>=20
>  int hv_vss_init(struct hv_util_service *srv);
>  void hv_vss_deinit(void);
> +int hv_vss_pre_suspend(void);
> +int hv_vss_pre_resume(void);
>  void hv_vss_onchannelcallback(void *context);
>=20
>  int hv_fcopy_init(struct hv_util_service *srv);
>  void hv_fcopy_deinit(void);
> +int hv_fcopy_pre_suspend(void);
> +int hv_fcopy_pre_resume(void);
>  void hv_fcopy_onchannelcallback(void *context);
>  void vmbus_initiate_unload(bool crash);
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 41c58011431e..692c89ccf5df 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1435,6 +1435,8 @@ struct hv_util_service {
>  	void (*util_cb)(void *);
>  	int (*util_init)(struct hv_util_service *);
>  	void (*util_deinit)(void);
> +	int (*util_pre_suspend)(void);
> +	int (*util_pre_resume)(void);
>  };
>=20
>  struct vmbuspipe_hdr {
> --
> 2.19.1

