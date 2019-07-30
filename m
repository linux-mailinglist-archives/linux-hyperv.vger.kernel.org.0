Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E320B7B635
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 01:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfG3XZm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 19:25:42 -0400
Received: from mail-eopbgr740128.outbound.protection.outlook.com ([40.107.74.128]:18208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfG3XZl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 19:25:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXxKenjl+hwgXbKC43AsRxKx4pXCbBPBtUNDgD+fa5naRkpWp1V8I5kUTQ6LOLwOC2EK1MY95hqSSV4FwI5EJmAlzvGqi/F8HyQVdWPKDR4XKi+XIWGwhVdDAIGLAMoi4pbzarzqciuCA4XZzQbEcpXTv/ysJqschNYuUvajVC0Ot7A9GCN/0UfxEcVpUW/5zAa6qRVxbjmXewQ+EvV2nnaMPMbH7751P6gBeNhzBBVHjgXQ/vRc+Ve0PoGsBefHH1D88WKRmnAIHk0Q4/fHcDmt8XkEbKX1bl3ftEdEr/KUZiJ4oJ0ZzrXLdg6OYhHRYGZOY1bFVa2nTTtZ8FwNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsr3gizro2CSNJJQkVckX7KsKf5v5TtfRXEnvL/Pi4A=;
 b=nP7Yl//7bKmB96p5WyvwU7GtwHvp8AWQcVnxJwaLnyxe3za5RQXYga8PwIwoAqFyxCEVRIZdv21YdsmCgodX5XmWvi4pkqeN5hOuQVyOwT7DOaCDz6S72voghUKeDHB7ZgPBQor++4GkN/UOWubs1WLEsZAE/X+hTG/twDc0XgIUUrCuAR/M1QOuDideaQKxTQmvGYuHn/KXxbcOba/49haq7LLdG8emnsdI7b2QL7C04D8jhlw/MaSaegPUfX4XwSnfmNHrTDj/lsdQ93nfYS7EUrYPQAkLZzIDDtHPpi4QxQ9eVVtYnQvtd2l4cLkgeT2PmCOsgL0nHmTaH/42Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsr3gizro2CSNJJQkVckX7KsKf5v5TtfRXEnvL/Pi4A=;
 b=e6eDrtB004T8Is7Vw2X4aIjyMKWUAu9LRzQ/wtNN0IoL/TMcn/8CG1lxpT4eQ0hkeCg9/yXjw37/tFa8AHuU1MaprM6oDOPiVYzDr445dqjPwaUIIpDt0chjpbBZ79oumonv9VAb/p1YLBnMIhU+ZBdqCoCcpT2ogAiShUsvmCE=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0141.namprd21.prod.outlook.com (10.173.52.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 23:25:37 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82%5]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 23:25:37 +0000
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
Subject: RE: [PATCH 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Topic: [PATCH 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Index: AQHVNhdJZWKYdNj8hk22NGM1tZCwVabj7olQ
Date:   Tue, 30 Jul 2019 23:25:37 +0000
Message-ID: <MWHPR21MB078461F2DB6FE0A6D0647B70D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-7-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-7-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T23:25:35.5916184Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3253bf88-42be-4c76-912a-1ac61c3e3840;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ced21867-f5f6-4ff6-405f-08d715453a69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0141;
x-ms-traffictypediagnostic: MWHPR21MB0141:|MWHPR21MB0141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0141FB6A597D3522206D0730D7DC0@MWHPR21MB0141.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(76116006)(6436002)(305945005)(66556008)(66446008)(6246003)(66946007)(8936002)(81166006)(10090500001)(110136005)(4326008)(71190400001)(71200400001)(14444005)(74316002)(8676002)(8990500004)(86362001)(316002)(99286004)(22452003)(81156014)(68736007)(25786009)(53936002)(1511001)(256004)(7736002)(10290500003)(55016002)(186003)(76176011)(7696005)(26005)(5660300002)(478600001)(2201001)(52536014)(486006)(15650500001)(446003)(6506007)(102836004)(476003)(11346002)(9686003)(14454004)(229853002)(2906002)(66066001)(33656002)(6116002)(64756008)(2501003)(3846002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0141;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VigwI7kJMX3mZ+YlzGJ60jYSKicmg6PG14rhH94BfoCuxYu9vONviXEU10nldifbqRTPseS6VGloiiH3c3YnneY31k/VWO6eh9ZUbRD6Ovjtsg8dU7loz6b1fOIilhwPsqvfFzcVWBxCe1BGymvj1Bn3IKlmlQyVCSRpH5d+620PQEaCIcmj149tl/v7r3Kf5Xw4IkIWtwuKsvZ3krPAQH1diK5fbI8xZjRf/Zh9DCSoWljsmfa+mtJK2stvjL+k2XnALMVJL1anDFfMI4n5Z4MR62LsBjqiq+on8eUCouSgl5G5sH+DEz61D+4sKgcj7ix7kVQXEv6jWuUSu4Tb5r8kcrPaqQfncte7OmLosn6GH//onhAiV9Ry5Zb7nqYTKJM5JUq813fs+IfBFPl3LnGcAu51gAdOIc558AjCorI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced21867-f5f6-4ff6-405f-08d715453a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 23:25:37.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+EnvyBczv6uKZGfE36gTgHsvIKtzgJhVXOn3KkdRGOHVVVDpfJrvI/ONsQCRvYxRlEomhHvs8oY32oNQ79E6amiHDS+q9mMs2DSA3UcjeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0141
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, July 8, 2019 10:30 PM
>=20
> This is needed when we resume the old kernel from the "current" kernel.

Perhaps a bit more descriptive commit message could be supplied?

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/connection.c   |  3 +--
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  drivers/hv/vmbus_drv.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 09829e1..806319c 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -59,8 +59,7 @@ static __u32 vmbus_get_next_version(__u32 current_versi=
on)
>  	}
>  }
>=20
> -static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo=
,
> -					__u32 version)
> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
>  {
>  	int ret =3D 0;
>  	unsigned int cur_cpu;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 26ea161..e657197 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -274,6 +274,8 @@ struct vmbus_msginfo {
>=20
>  extern struct vmbus_connection vmbus_connection;
>=20
> +int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion);
> +
>  static inline void vmbus_send_interrupt(u32 relid)
>  {
>  	sync_set_bit(relid, vmbus_connection.send_int_page);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1c2d935..1730e7b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2045,6 +2045,41 @@ static int vmbus_acpi_add(struct acpi_device *devi=
ce)
>  	return ret_val;
>  }
>=20
> +static int vmbus_bus_suspend(struct device *dev)
> +{
> +	vmbus_initiate_unload(false);
> +
> +	vmbus_connection.conn_state =3D DISCONNECTED;
> +
> +	return 0;
> +}
> +
> +static int vmbus_bus_resume(struct device *dev)
> +{
> +	struct vmbus_channel_msginfo *msginfo;
> +	size_t msgsize;
> +	int ret;
> +
> +	msgsize =3D sizeof(*msginfo) +
> +		  sizeof(struct vmbus_channel_initiate_contact);
> +
> +	msginfo =3D kzalloc(msgsize, GFP_KERNEL);
> +
> +	if (msginfo =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ret =3D vmbus_negotiate_version(msginfo, vmbus_proto_version);

I think this code answers my earlier question:  Upon resume, we negotiate t=
he same
VMbus protocol version we had at time of hibernation, even if running on a =
newer
version of Hyper-V that might support newer protocol versions.  Hence the o=
ffer
messages should not have any previously reserved fields now being used.   A
comment to this effect would be useful.

> +
> +	kfree(msginfo);
> +
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	vmbus_request_offers();
> +
> +	return 0;
> +}
> +
>  static const struct acpi_device_id vmbus_acpi_device_ids[] =3D {
>  	{"VMBUS", 0},
>  	{"VMBus", 0},
> @@ -2052,6 +2087,10 @@ static int vmbus_acpi_add(struct acpi_device *devi=
ce)
>  };
>  MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
>=20
> +static const struct dev_pm_ops vmbus_bus_pm =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(vmbus_bus_suspend, vmbus_bus_resume)
> +};
> +
>  static struct acpi_driver vmbus_acpi_driver =3D {
>  	.name =3D "vmbus",
>  	.ids =3D vmbus_acpi_device_ids,
> @@ -2059,6 +2098,7 @@ static int vmbus_acpi_add(struct acpi_device *devic=
e)
>  		.add =3D vmbus_acpi_add,
>  		.remove =3D vmbus_acpi_remove,
>  	},
> +	.drv.pm =3D &vmbus_bus_pm,
>  };
>=20
>  static void hv_kexec_handler(void)
> --
> 1.8.3.1

