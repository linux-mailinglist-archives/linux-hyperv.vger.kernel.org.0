Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2423F9B789
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbfHWUCR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 16:02:17 -0400
Received: from mail-eopbgr780135.outbound.protection.outlook.com ([40.107.78.135]:20101
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731433AbfHWUCR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 16:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5JtAxjZZvqXqsW8KDxxQ57OoKtN+v/cQJFRGlm8Cpex5J2/+sM3Z8kxzSXOli7fBklPDxTZon7UvNbZIt/r9mlu6c2/maxQ2F8cCBVUxhZovFNNyu4KckwkZd7QWYU6WiHVdhw43KisguFISyJsrba7CUKqzFUwAPI+PHwMbCb/GCbr3Is17JTkx7m1EPY2w96CPccdOM4PdyiIyljCtfDFd4x/H77J12xuNfF61b+35HR6isKedKtfG7sejDIXKYwOyT/4UCmKnmBGfnYUrUKPAJvelUjTB2rb1NDsIrKVbLjapligilQ6Mn1xRhGNSIm1YsCgyhJaLweoWqjGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfBjRekI2JdXph6+vahyKvdntD8Lv/3yFdk/y+H9h7s=;
 b=dSbY1RGkFOmyFN3W7YzZtKx2EzPRyKTcExvgSR/DuHMe4H2VF9gA4OkRk5UjgDsG85eQZ4rxmnKKqryG0GUKAWt9rfnqAumbi49H7N4wCxXcip2+fh3XG/YMwbFfIw5h++c2OSfTp19aeb80Hk53kYbU83TG+hiPS8s1jNUJoJfBDN/dTfuZ5QUqydRqBMauQiiRVAhGviGLFE08WS6OOpR6/eGJTNB73N9g0aIe6H7GB2fzUiw/JY0lr4mXvR3IzC58Ac05lEuuWxvZS+h5Vp35BKkN2JbeFegz7hBaw06F22E7WrB0vXr3XMMAi8H3nv9tGeqToZqKg14W/Qt5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfBjRekI2JdXph6+vahyKvdntD8Lv/3yFdk/y+H9h7s=;
 b=SUjo8NWbK58plLekubemO2HZQae1VKYDrSi2V9IkmCYFi2YfzXxJpBBItKQpO0BYsC1vAyjqinNFC+F41A/kl2uOhwzOZ4dzarYOVC2os3DEUl7jtuj2h1mw1QY2HaULE8WIpO4Tb2qAw23YqE830z2la1krgvxIurJrQt3W+2k=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0281.namprd21.prod.outlook.com (10.173.174.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.3; Fri, 23 Aug 2019 20:02:12 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 20:02:12 +0000
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
Subject: RE: [PATCH v3 10/12] Drivers: hv: vmbus: Clean up hv_sock channels by
 force upon suspend
Thread-Topic: [PATCH v3 10/12] Drivers: hv: vmbus: Clean up hv_sock channels
 by force upon suspend
Thread-Index: AQHVVvngIm13qifSzE6BddexMOZgK6cJK+3g
Date:   Fri, 23 Aug 2019 20:02:12 +0000
Message-ID: <DM5PR21MB013722B88011C7D587BB6182D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-11-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-11-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T20:02:10.5815340Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9569c2bc-1aff-407a-a5da-655ff005400a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ee8d121-e0b6-4154-9bb5-08d72804c9d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0281;
x-ms-traffictypediagnostic: DM5PR21MB0281:|DM5PR21MB0281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0281EE7554F38CF0D9E35B22D7A40@DM5PR21MB0281.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(1511001)(186003)(2201001)(8990500004)(26005)(10090500001)(8936002)(8676002)(9686003)(6506007)(102836004)(86362001)(14454004)(81166006)(2501003)(52536014)(81156014)(74316002)(3846002)(305945005)(71190400001)(15650500001)(14444005)(256004)(4326008)(76176011)(33656002)(7696005)(66946007)(6116002)(5660300002)(2906002)(71200400001)(53936002)(7736002)(316002)(22452003)(66446008)(11346002)(446003)(76116006)(476003)(486006)(6436002)(229853002)(110136005)(66556008)(66476007)(25786009)(478600001)(64756008)(10290500003)(99286004)(6246003)(55016002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0281;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W/1SFnfBP+3cQb4Di8kNUa9A9WEAHYBB0XjkBbrolUe034l/izBcKdUgjrG2QJzC1NY4Z+hA8823sLalzlNFR+vHWr6x3cznfGLdjkQLAJ6Nf+V3Z4cdN8a3P95Ssn6RttKMHuvfMltOunJNuwDqW2eNDFk4EhS0EEFSWdCQLocP06L+f4xBiQBVXu3mPJt6+fOwW2ZGvSpfGaUnLMUb1vkRTzsxaxkrp/p8nZHWuGBBKtG9X4eeWlAJ05tlKbH/zJubTtZh7eaX1ok+U8jyGLgNk3wWf1na7+yogFfSGtxG3B2QuXfCt33L4nVobiwHqwin65z5msEBhGGg5EfkYvav98DQ3g26P346LO3C5aAS6ENLaJbQgpIJwhTSFDy0BC0hHhihxvCQktgaRoj3QJ5iKUfZ3VWeQHIU3DgX0Lk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee8d121-e0b6-4154-9bb5-08d72804c9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 20:02:12.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzXq0WsoMB1/S3zFyiLu7qEfi6yX1DxdRe80zZGDpM26Uy30CEX1RFsupzoveD7sLPZmi/w5SzRMxMaYb3K7xFre7UpriFahSCUTG/QrLSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0281
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, August 19, 2019 6:52 P=
M
>=20
> Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force for
> hibernation. There is no better method to clean up the channels since
> some of the channels may still be referenced by the userspace apps when
> hiberantin is triggered: in this case, the "rescind" fields of the

s/hiberantin/hibernation/

> channels are set, and the apps will thoroughly destroy the channels
> after hibernation.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 55
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index ce9974b..2bea669 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -24,6 +24,7 @@
>  #include <linux/sched/task_stack.h>
>=20
>  #include <asm/mshyperv.h>
> +#include <linux/delay.h>
>  #include <linux/notifier.h>
>  #include <linux/ptrace.h>
>  #include <linux/screen_info.h>
> @@ -1069,6 +1070,41 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	vmbus_signal_eom(msg, message_type);
>  }
>=20
> +/*
> + * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force f=
or
> + * hibernation, because hv_sock connections can not persist across hiber=
nation.
> + */
> +static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
> +{
> +	struct onmessage_work_context *ctx;
> +	struct vmbus_channel_rescind_offer *rescind;
> +
> +	WARN_ON(!is_hvsock_channel(channel));
> +
> +	/*
> +	 * sizeof(*ctx) is small and the allocation should really not fail,
> +	 * otherwise the state of the hv_sock connections ends up in limbo.
> +	 */
> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
> +
> +	/*
> +	 * So far, these are not really used by Linux. Just set them to the
> +	 * reasonable values conforming to the definitions of the fields.
> +	 */
> +	ctx->msg.header.message_type =3D 1;
> +	ctx->msg.header.payload_size =3D sizeof(*rescind);
> +
> +	/* These values are actually used by Linux. */
> +	rescind =3D (struct vmbus_channel_rescind_offer *)ctx->msg.u.payload;
> +	rescind->header.msgtype =3D CHANNELMSG_RESCIND_CHANNELOFFER;
> +	rescind->child_relid =3D channel->offermsg.child_relid;
> +
> +	INIT_WORK(&ctx->work, vmbus_onmessage_work);
> +
> +	queue_work_on(vmbus_connection.connect_cpu,
> +		      vmbus_connection.work_queue,
> +		      &ctx->work);
> +}
>=20
>  /*
>   * Direct callback for channels using other deferred processing
> @@ -2091,6 +2127,25 @@ static int vmbus_acpi_add(struct acpi_device *devi=
ce)
>=20
>  static int vmbus_bus_suspend(struct device *dev)
>  {
> +	struct vmbus_channel *channel;
> +
> +	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {
> +		/*
> +		 * We wait here until any channel offer is currently
> +		 * being processed.
> +		 */

The wording of the comment is a bit off.  Maybe

		/*
		 * We wait here until the completion of any channel
		 * offers that are currently in progress.
		 */

> +		msleep(1);
> +	}
> +
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (!is_hvsock_channel(channel))
> +			continue;
> +
> +		vmbus_force_channel_rescinded(channel);
> +	}
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +
>  	vmbus_initiate_unload(false);
>=20
>  	vmbus_connection.conn_state =3D DISCONNECTED;
> --
> 1.8.3.1

Modulo the nits:

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

