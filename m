Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4093F18FB09
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 18:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgCWRMB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 13:12:01 -0400
Received: from mail-dm6nam10on2096.outbound.protection.outlook.com ([40.107.93.96]:6959
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbgCWRMB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 13:12:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIU148HlFKcJAZOn62yUlLUflfTa2PGxXOT2bYDDh8IYvnBI8dr6NT4coYLxzSgD2aSx27XLnONmq2YbYqkwswGsBYmn316zajZhgpnGSk9AsXz5b3vdG096PXwBpkW5uPYb54NtM5WWjqlvGBNz6lDO7ArpZxNlZxJVYO0wSIQm5hvf22ugnXPZfBheuep0rOA3lznjLoCQUuunHr5amAy2Y4eA0/lYQLLle+7lesy4ztBFl7t+wHuM98pzs34CwWNqGL0bKCeMyYZVffWeXH+N5FB3WpMxMAbti22qPkh+YZ6JiH+LEdTm6ZCbnXR2XsJRAFzBHExx9Wz0f7dizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szlSgQYgo1dJwGrEB1VWkbQkuIVdIYvYEokgveHsqlY=;
 b=Nhm2RxsqUM1HwzJeTsZpbYO9j1vxN0+O6Qpteubk1KuRq60HUf4D39CX9AWXQ1uesThimCeJJamPJC0yUGFg9FealcJyTLYHEr7GFsTI8aLMtPS+EfiwfLTB+nHZ6nDpkNDY5sPK+1CGZN2yZcTv6401zJXiruatL1GTQ4caJNpi5wb8aLeNpYbxif8rov1K8fHQJkQwXV4byyhyYvrgk4IMx9aENoRdEy4BtGXTFdXN2Y9sqMKYJygdtYaui08hczXVqy4tkvwdW63vEvunBSplodWBHbok/3yeZ8pZqHTVASUSlhJa9XW4QIYpvsKkE2coBif+/6H4QMXASXtcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szlSgQYgo1dJwGrEB1VWkbQkuIVdIYvYEokgveHsqlY=;
 b=NUODUb2ALzWiTdaaH+ULNgKy05zuvyEJjirCUskZbY37XkMFqEhkP/1QveMgRvZBMQmSxrh08mP+M8tKXHRDgKIWpPaqrFED8gWGm9a2awQIhmiQR/HU0feSluXOGaExX49IfyRLbBsYY7oVkCL0I1XgSs+6qmoiNrDegZoEDGc=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1035.namprd21.prod.outlook.com (2603:10b6:302:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Mon, 23 Mar
 2020 17:11:58 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.000; Mon, 23 Mar 2020
 17:11:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V2 1/6] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Topic: [PATCH V2 1/6] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Index: AQHWARRTG6F2V6RIgkCCc5DmsypG3KhWaJug
Date:   Mon, 23 Mar 2020 17:11:58 +0000
Message-ID: <MW2PR2101MB1052AF9A536BF4ABCFBB60E1D7F00@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
 <20200323130924.2968-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200323130924.2968-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-23T17:11:55.7980837Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c1ed3a4-d4b2-400c-9b24-bb8bf451e0f6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 613a7bbd-96a0-4879-741f-08d7cf4d4b8a
x-ms-traffictypediagnostic: MW2PR2101MB1035:|MW2PR2101MB1035:|MW2PR2101MB1035:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1035D00A775E0C3307B4A007D7F00@MW2PR2101MB1035.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(54906003)(55016002)(2906002)(5660300002)(6506007)(4326008)(478600001)(9686003)(10290500003)(110136005)(316002)(86362001)(81156014)(81166006)(7696005)(33656002)(8990500004)(26005)(66446008)(71200400001)(8676002)(8936002)(64756008)(66556008)(52536014)(76116006)(66476007)(66946007)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1035;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nm93+1fkU+JnELAtzI5HNnzEJcmXSys2VhcTozHT0URJ0F+rs/hgQfNoF1Dt9WMqgnR02X8C+H1tvoJilpiJAVV97i9LImcdN8ub2+e2TcibdRwjgQzkhnDCug04jqJUfpZrYuJseaPAYi/NLnEs4C8nJmlv11ql/c7HpXlvHtBNiSG1iLgMK2VsKcjNpntq6Wg9HUT+uv9XvYJqUdVl4Vz2vjGahCnNwlWP7HxMYStZZe/kUvWwoTDvgOYgOw7xLbBzjbGlV53xe8yXYCF4ygENEButNX8I7lDQsMMUHmJscKSrLMMNIJixqmVWjRsxaZbHVbX51QLRYtCu7e+hSGrM/xsYTG6rD7Z4oHxvMsaYgHusSIgZo5NnvPUOYWLeHoRXPEsH/3pmvn+28w4hIZihN2LOjiXqwejvK4fGAuJ58Ts/9U23e0BnFGN2rXHmicxSTxGoulRk7xhaDJ7k7U+e2A14FUla5/MVP5ucNPu6FnzAuhinEdQhUQDQi2+
x-ms-exchange-antispam-messagedata: aTNNnUE52qxGOPMEhJ8uuX7wT/OOrrfrD29gStXg+NFPdXucobeouXE0u2PgOiDH67z3+pNk4ySzy2aFm3gPCReQuF0JwVipLqSlPCxTXQTT5iIUUFls6G5McN35tdoxVZjhp9F3FAr8NC3DVXcqOg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613a7bbd-96a0-4879-741f-08d7cf4d4b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 17:11:58.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9v2ikrQPRHnyTSC4ZV25nGpwsDB/i5P0urDTuDL2EBic0rooSLDhxq2UI2N5yVuzp/uceZuWilOiQn1jmF7LstEXcYsTa2eqPN2iyfaNYeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1035
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, March 23, 2020 6:=
09 AM
>=20
> When kdump is not configured, a Hyper-V VM might still respond to
> network traffic after a kernel panic when kernel parameter panic=3D0.
> The panic CPU goes into an infinite loop with interrupts enabled,
> and the VMbus driver interrupt handler still works because the
> VMbus connection is unloaded only in the kdump path.  The network
> responses make the other end of the connection think the VM is
> still functional even though it has panic'ed, which could affect any
> failover actions that should be taken.
>=20
> Fix this by unloading the VMbus connection during the panic process.
> vmbus_initiate_unload() could then be called twice (e.g., by
> hyperv_panic_event() and hv_crash_handler(), so reset the connection
> state in vmbus_initiate_unload() to ensure the unload is done only
> once.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
> 	- Update chnage log
> 	- Use xchg() to change vmbus connection status
> ---
>  drivers/hv/channel_mgmt.c |  3 +++
>  drivers/hv/vmbus_drv.c    | 17 +++++++++--------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 0370364169c4..501c43c5851d 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
>  {
>  	struct vmbus_channel_message_header hdr;
>=20
> +	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) =3D=3D DISCONNECTE=
D)
> +		return;
> +
>  	/* Pre-Win2012R2 hosts don't support reconnect */
>  	if (vmbus_proto_version < VERSION_WIN8_1)
>  		return;
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 029378c27421..b56b9fb9bd90 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *n=
b, unsigned
> long val,
>  {
>  	struct pt_regs *regs;
>=20
> -	regs =3D current_pt_regs();
> +	vmbus_initiate_unload(true);
>=20
> -	hyperv_report_panic(regs, val);
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +		regs =3D current_pt_regs();
> +		hyperv_report_panic(regs, val);
> +	}
>  	return NOTIFY_DONE;
>  }
>=20
> @@ -1391,10 +1394,12 @@ static int vmbus_bus_init(void)
>  		}
>=20
>  		register_die_notifier(&hyperv_die_block);
> -		atomic_notifier_chain_register(&panic_notifier_list,
> -					       &hyperv_panic_block);
>  	}
>=20
> +	/* Vmbus channel is unloaded in panic callback when panic happens.*/

Let me suggest a tweak to the above comment so it is super clear:

	/*
	 * Always register the panic notifier because we need to unload
	 * the VMbus channel connection to prevent any VMbus
	 * activity after the VM panics.
	 */

> +	atomic_notifier_chain_register(&panic_notifier_list,
> +			       &hyperv_panic_block);
> +
>  	vmbus_request_offers();
>=20
>  	return 0;
