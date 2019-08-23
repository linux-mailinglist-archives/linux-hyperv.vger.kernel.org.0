Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9E9B79A
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406158AbfHWUQw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 16:16:52 -0400
Received: from mail-eopbgr720094.outbound.protection.outlook.com ([40.107.72.94]:41184
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730896AbfHWUQv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 16:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0RxAQFespFZhWnWz3b/9QJkJGi64/287DbNDYZSHmPfPj6PiQ/Lyq1RiEE/XeaJ6MICZmAH85IpecqGn9+xaJ6AqM8+g1pyn81MolHw/GfGtal4QqxsE210Ls+UoVZSbt5GYEfp+7rLNh4JrmLaBHUgZNnEKfvUXvOlsPiwG7E+gWasGqQup63ggUCZEKLUL8TY4s2ScCnPQxdNe83UbxsmXVRcxiWuOry+txF98wt8Zbcy6X7Ls59V+BpS6s/cSxcFIR/lJYCnMS2LPvXQHEcf7I9UFouL11mKRnZpF/e/WlYfoVGGv19spmAMJZQu0Ucb1Uf7+bOVhgSF+yGBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioKH5LziqWRCBJhCcnFJupRrKpZcw/RX81XmRJ/3R1A=;
 b=grkX8i2k4lSw1gOZjIamEDShnCY2EeqnckrQzrfOpw7SS2iY/7mwc/x1Ablg6zEY7CrxCwK2OsTobG9/w3h5n+Y+hmD4kvs9njNh6BaVfX6CYd5C54yfuzNNQKbHWrCW0NqHrfw8GQCmEubG22GYdFlGxdGHQJ1jIeM1GwdD5gz5mMV93ivXaX36Z9BWTtDH4+V9o0CqsP9wGmVImp0fAaS7E9+puvg9O4Xq7i6auPC2U2Fw63lflfh8Qa+krSpq2dKG4UTeOwMG5IjLwkyo4kIRQHkfmIiOST4XBrzs1HkJJ5RQIR0U/7OVGoCm2u+fAdT2/l/hMYSgMzrK8c1iKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioKH5LziqWRCBJhCcnFJupRrKpZcw/RX81XmRJ/3R1A=;
 b=Sm2secHPoJ9cXv+RrWJ32p4x0drdsS3j5sluUrsa/QcVFa1NicrRVZT/zHVACCpMyPBeG3zWYoqaMLilJOPsUeXHHSR+Y3IE/hGb9YBeMxjc2lRKsfKGBKzJWW1KPhCQeVH3FA8/4yHIM0RnWFcnqr+IqhvYgRgkxprKeuK4oNo=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0139.namprd21.prod.outlook.com (10.173.173.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Fri, 23 Aug 2019 20:16:45 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 20:16:45 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Topic: [PATCH v3 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Index: AQHVVvng6z85mw3tx0a0PJJjmBG2NqcJLWIg
Date:   Fri, 23 Aug 2019 20:16:45 +0000
Message-ID: <DM5PR21MB01379C31FC628F4666413804D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-12-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-12-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:16:43.0778197Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=338b832f-f4fa-45d4-b0dc-f0e1b91ce4cc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4eba9ba-774f-4b67-d91b-08d72806d1ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0139;
x-ms-traffictypediagnostic: DM5PR21MB0139:|DM5PR21MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0139C54EBECE4C3E05AF67CFD7A40@DM5PR21MB0139.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(10290500003)(66476007)(7696005)(8936002)(76176011)(76116006)(66556008)(316002)(66946007)(186003)(22452003)(66066001)(10090500001)(305945005)(7736002)(2201001)(1511001)(476003)(11346002)(446003)(33656002)(74316002)(81166006)(25786009)(81156014)(64756008)(8676002)(66446008)(478600001)(8990500004)(53936002)(15650500001)(4326008)(14454004)(110136005)(99286004)(486006)(86362001)(52536014)(71190400001)(71200400001)(26005)(14444005)(256004)(6246003)(2501003)(6436002)(2906002)(6506007)(5660300002)(6116002)(9686003)(3846002)(229853002)(55016002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0139;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BqcQIk8bn2E/2HY/jhLcBYRTf0Dtj4IOkzCO7r/ztDpX9H/gJ5YIcTYbmOEPc4obNjg2uzJl2nn1o11QuLBXnVFdlgdR2pnErbaQwlspUBZQPnU3G0xtTrFpoYFLeitsI6ZBFOvsaS01xYUc+o9b3dO7bIYi1Ho3Ha0LfY1JOsDYdhocB0YL7hFARu2Qzee2vxRPSuzQuDfrZk62w30xYLe4S3xWxvZnC3D0ot4JGc9/MIeXT9dhH0728bOJpPpA5oFMNxIpBgDPRmLc+YTzcwaliyOuPpo2wCnwWLiknYZtdQfaiBO7Q874HzVkhczlokdPIxlpgP0boM/9EgJFsN+wHJqGXRNrF5MD+AkmzrzIzxRB7ISdair29rTxovW9CMhg6mIhXjSdCew5rIwe8j2cannNgly7xD885dR4BE0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eba9ba-774f-4b67-d91b-08d72806d1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 20:16:45.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAPgzLbsHq2zzSUUi7eCZ8NWlilK4LdzwyqrMVxv2vyVYEgyqUtVCfdNnqu/THoMWpsvpyUV63JxEF69bVHilIbZx40vsQ5bV789mDwdUJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0139
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, August 19, 2019 6:52 P=
M
>=20
> Before suspend, Linux must make sure all the hv_sock channels have been
> properly cleaned up, because a hv_sock connection can not persist across
> hibernation, and the user-space app must be properly notified of the
> state change of the connection.
>=20
> Before suspend, Linux also must make sure all the sub-channels have been
> destroyed, i.e. the related channel structs of the sub-channels must be
> properly removed, otherwise they would cause a conflict when the
> sub-channels are recreated upon resume.
>=20
> Add a counter to track such channels, and vmbus_bus_suspend() should wait
> for the counter to drop to zero.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 28 ++++++++++++++++++++++++++++
>  drivers/hv/connection.c   |  3 +++
>  drivers/hv/hyperv_vmbus.h | 12 ++++++++++++
>  drivers/hv/vmbus_drv.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 83 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index f7a1184..8491d1b 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -499,6 +499,8 @@ static void vmbus_add_channel_work(struct work_struct=
 *work)
>  	return;
>=20
>  err_deq_chan:
> +	WARN_ON_ONCE(1);
> +

Why this change?  I was thinking maybe it's a debug statement that got
left in.

>  	mutex_lock(&vmbus_connection.channel_mutex);
>=20
>  	/*
> @@ -545,6 +547,10 @@ static void vmbus_process_offer(struct vmbus_channel
> *newchannel)
>=20
>  	mutex_lock(&vmbus_connection.channel_mutex);
>=20
> +	/* Remember the channels that should be cleaned up upon suspend. */
> +	if (is_hvsock_channel(newchannel) || is_sub_channel(newchannel))
> +		atomic_inc(&vmbus_connection.nr_chan_close_on_suspend);
> +
>  	/*
>  	 * Now that we have acquired the channel_mutex,
>  	 * we can release the potentially racing rescind thread.
> @@ -915,6 +921,16 @@ static void vmbus_onoffer(struct
> vmbus_channel_message_header *hdr)
>  	vmbus_process_offer(newchannel);
>  }
>=20
> +static void check_ready_for_suspend_event(void)
> +{
> +	/*
> +	 * If all the sub-channels or hv_sock channels have been cleaned up,
> +	 * then it's safe to suspend.
> +	 */
> +	if (atomic_dec_and_test(&vmbus_connection.nr_chan_close_on_suspend))
> +		complete(&vmbus_connection.ready_for_suspend_event);
> +}
> +
>  /*
>   * vmbus_onoffer_rescind - Rescind offer handler.
>   *
> @@ -925,6 +941,7 @@ static void vmbus_onoffer_rescind(struct
> vmbus_channel_message_header *hdr)
>  	struct vmbus_channel_rescind_offer *rescind;
>  	struct vmbus_channel *channel;
>  	struct device *dev;
> +	bool clean_up_chan_for_suspend;
>=20
>  	rescind =3D (struct vmbus_channel_rescind_offer *)hdr;
>=20
> @@ -964,6 +981,8 @@ static void vmbus_onoffer_rescind(struct
> vmbus_channel_message_header *hdr)
>  		return;
>  	}
>=20
> +	clean_up_chan_for_suspend =3D is_hvsock_channel(channel) ||
> +				    is_sub_channel(channel);
>  	/*
>  	 * Before setting channel->rescind in vmbus_rescind_cleanup(), we
>  	 * should make sure the channel callback is not running any more.
> @@ -989,6 +1008,10 @@ static void vmbus_onoffer_rescind(struct
> vmbus_channel_message_header *hdr)
>  	if (channel->device_obj) {
>  		if (channel->chn_rescind_callback) {
>  			channel->chn_rescind_callback(channel);
> +
> +			if (clean_up_chan_for_suspend)
> +				check_ready_for_suspend_event();
> +
>  			return;
>  		}
>  		/*
> @@ -1021,6 +1044,11 @@ static void vmbus_onoffer_rescind(struct
> vmbus_channel_message_header *hdr)
>  		}
>  		mutex_unlock(&vmbus_connection.channel_mutex);
>  	}
> +
> +	/* The "channel" may have been freed. Do not access it any longer. */
> +
> +	if (clean_up_chan_for_suspend)
> +		check_ready_for_suspend_event();
>  }

Having to add the above lines twice is a bit clumsy, but the problem is
the overall structure of the vmbus_onoffer_rescind.  The early return in
the case of a rescind_callback function is a bit weird, but I guess it make=
s
sense since from what I can tell, only uio and hv_sock have rescind callbac=
k
functions.   Some minor restructuring might be warranted, but I don't feel
strongly about it.

>=20
>  void vmbus_hvsock_device_unregister(struct vmbus_channel *channel)
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 701d9a8..f15d3115 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -26,6 +26,9 @@
>  struct vmbus_connection vmbus_connection =3D {
>  	.conn_state		=3D DISCONNECTED,
>  	.next_gpadl_handle	=3D ATOMIC_INIT(0xE1E10),
> +
> +	.ready_for_suspend_event=3D COMPLETION_INITIALIZER(
> +				  vmbus_connection.ready_for_suspend_event),
>  };
>  EXPORT_SYMBOL_GPL(vmbus_connection);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 4610277..9f96e23 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -258,6 +258,18 @@ struct vmbus_connection {
>  	struct workqueue_struct *work_queue;
>  	struct workqueue_struct *handle_primary_chan_wq;
>  	struct workqueue_struct *handle_sub_chan_wq;
> +
> +	/*
> +	 * The number of sub-channels and hv_sock channels that should be
> +	 * cleaned up upon suspend: sub-channels will be re-created upon
> +	 * resume, and hv_sock channels should not survive suspend.
> +	 */
> +	atomic_t nr_chan_close_on_suspend;
> +	/*
> +	 * vmbus_bus_suspend() waits for "nr_chan_close_on_suspend" to
> +	 * drop to zero.
> +	 */
> +	struct completion ready_for_suspend_event;
>  };
>=20
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2bea669..0507157 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2127,7 +2127,8 @@ static int vmbus_acpi_add(struct acpi_device *devic=
e)
>=20
>  static int vmbus_bus_suspend(struct device *dev)
>  {
> -	struct vmbus_channel *channel;
> +	struct vmbus_channel *channel, *sc;
> +	unsigned long flags;
>=20
>  	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {
>  		/*
> @@ -2146,6 +2147,41 @@ static int vmbus_bus_suspend(struct device *dev)
>  	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
> +	/*
> +	 * Wait until all the sub-channels and hv_sock channels have been
> +	 * cleaned up. Sub-channels should be destroyed upon suspend, otherwise
> +	 * they would conflict with the new sub-channels that will be created
> +	 * in the resume path. hv_sock channels should also be destroyed, but
> +	 * a hv_sock channel of an established hv_sock connection can not be
> +	 * really destroyed since it may still be referenced by the userspace
> +	 * application, so we just force the hv_sock channel to be rescinded
> +	 * by vmbus_force_channel_rescinded(), and the userspace application
> +	 * will thoroughly destroy the channel after hibernation.
> +	 */
> +	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)

At first glance, the above line seemed useless to me.  You could just do th=
e
wait_for_completion() unconditionally.  But is the intent to handle the cas=
e where
the VM never had any sub-channels or hv_sock channels, and so
nr_chan_close_on_suspend never went above 0?  If so, a comment might
be helpful.

> +		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
> +
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (is_hvsock_channel(channel)) {
> +			if (!channel->rescind) {
> +				pr_err("hv_sock channel not rescinded!\n");
> +				WARN_ON_ONCE(1);
> +			}
> +			continue;
> +		}
> +
> +		spin_lock_irqsave(&channel->lock, flags);
> +		list_for_each_entry(sc, &channel->sc_list, sc_list) {
> +			pr_err("Sub-channel not deleted!\n");
> +			WARN_ON_ONCE(1);
> +		}
> +		spin_unlock_irqrestore(&channel->lock, flags);
> +	}
> +
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +
>  	vmbus_initiate_unload(false);
>=20
>  	vmbus_connection.conn_state =3D DISCONNECTED;
> @@ -2186,6 +2222,9 @@ static int vmbus_bus_resume(struct device *dev)
>=20
>  	vmbus_request_offers();
>=20
> +	/* Reset the event for the next suspend. */
> +	reinit_completion(&vmbus_connection.ready_for_suspend_event);
> +
>  	return 0;
>  }
>=20
> --
> 1.8.3.1

