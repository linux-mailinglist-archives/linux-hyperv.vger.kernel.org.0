Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7A18A9F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 01:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCSAqB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 20:46:01 -0400
Received: from mail-mw2nam10on2105.outbound.protection.outlook.com ([40.107.94.105]:19168
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbgCSAqA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 20:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b82Qb0TatJLtI2Codq3i8JSC7V9lEk8thOq+VO0rTpBjY/h4bDzrNjDpmZAdqMVKSpGN8lk+OdaK5CjHyYIt69aPqkClbXWKO0GaYdnrWsrKpUzGRCcun30+hTE1Tnmv9f5ghcu85+psIM7j6MroVVuktm5jZzyJU6AllozCl+alPfmN3ODjVj9GpyDCxk4YnjZ66bI2swOebCyLM/upMgFRZPcHjQdde55SHUveaI/6XxkCdKbScx4MDNYsy3k/pbtJCUK4rAAxjSz/qEPsasEDa2mG2TSXAq6cfGLE2F2vsjZ+zQ7YoLUUzpPb4OaCkasp5jJfDltxfYI8z0hR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV/nhAVByx8/jGXB+97ZazBB2eBL1QtcT1jTxYys4V0=;
 b=WffuJmUAxV/Szy0X/b6VIZYc1h3zRnJSc9Xdg29pje5VV7/em42ujoJ2XbQQG/JsDXg1cVoDIY4bHGMQvPYL83PDcTUjF3mwsVjJVVq4TcFgf/jZqUFYoUApo++GSxONCQbbLK98hfFVmuO4EOeUdU0DmtUaM8/VCRvuWafR8IBAygFYKWBUHoi6E4vgu59ipKyLB1VavKAdnqek0+mVBooOCcU9CV6HfTw44nSZ7njUN9ayYdnHzGWhC1Nldcz4bjA0jKoCTVn/lxwNfd/2sA7Wr4emnGzKqBbH6SCg1XYSbj38vEk0vNjVoMEq0jxwOg+LoqmRb8oy/iJSSBDTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV/nhAVByx8/jGXB+97ZazBB2eBL1QtcT1jTxYys4V0=;
 b=gMgArnBylp30VIsAh4tO9S7gNZ6g9yJAcVvt0nBMQ3tw1imDq3KMFRjTooAMfpyCQIHHEpy4iMOTFrp7BGq440nH2AUC24k5nCLXfm8U0YZccSSga4QFh8RqgIlavIrpYOzdkoFT9IwJPm8OF1TgUtwnMH2WyqBtCaSGhPQiSCs=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0937.namprd21.prod.outlook.com (2603:10b6:302:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.2; Thu, 19 Mar
 2020 00:45:16 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Thu, 19 Mar 2020
 00:45:16 +0000
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
Subject: RE: [PATCH 3/4] x86/Hyper-V: Trigger crash enlightenment only once
 during system crash.
Thread-Topic: [PATCH 3/4] x86/Hyper-V: Trigger crash enlightenment only once
 during system crash.
Thread-Index: AQHV/F+KzUALdljO+kyyp8Deinbn3KhPFKGA
Date:   Thu, 19 Mar 2020 00:45:16 +0000
Message-ID: <MW2PR2101MB1052BABDBF2AD9AD0EF15B47D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-4-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200317132523.1508-4-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T00:45:13.9057515Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64b49a2a-fe01-404b-a9b3-dfb847659add;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85186abf-e12d-4dbf-147c-08d7cb9ecade
x-ms-traffictypediagnostic: MW2PR2101MB0937:|MW2PR2101MB0937:|MW2PR2101MB0937:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09375D90EADB7F9848CDDD46D7F40@MW2PR2101MB0937.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(2906002)(4326008)(55016002)(66946007)(8936002)(478600001)(7696005)(54906003)(110136005)(76116006)(316002)(26005)(9686003)(33656002)(81156014)(10290500003)(71200400001)(81166006)(8990500004)(86362001)(66556008)(8676002)(66446008)(64756008)(66476007)(186003)(52536014)(5660300002)(6506007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0937;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xRXqAiSXY2GmJSJF+fjTXtCjdjYfpPVYdvomv/gXLJ99CyFxRGbA2wDuqGH3qujw1cbNnr2Bo1opSsvksDicmm8wrNvZDjy87f3wtoq2wP1EaKN7w6t9GerLhKt5n4UAJguFFT9ez0HbuIAQu9QXU8Q61tosFw9wIgWKQ3cF1CcGPy30BvvqGnCk2EDc/WqhknhgxatngWWDCtddwcVqUQR1lYgolKX15p9Rx95oOQG9F/F3ISI4ZhWvC3LaWcDyVcjkP0DZW4ZukwOg7tgQe+9qX9DNCOTRR6uA+L/oS/aHMdKJajmnTa6CDEhV6sEpUzIElrP9+N7zYG9Re0RmBMMTj1V6AQE51YcCvTr3C8DzlnUimjqoPJZn9gJroL3l3qc9HC8GrSv8d1sMmVkQY4QhpqqypPiiRO1lB3yK8ji0P0OAxQ2cEcYw2dA9U/nMZ0VfVXbbLzxf9L3jiWxkVL3r50W0Ixzv+omKRBBUchsvl3o3+qIIkvLAZA6x3TQ
x-ms-exchange-antispam-messagedata: HcRXldSbcJbHcSnRqXMppS4Rtf9FUgREKJSD8FvtyvEZLpte2XiiIvf6cJaGfxCToUn/NnmMHuObb8wSpAHvWhXPBodMqOipX2LuQnA0akXTpJLj2VjupWyHDk+AOauhcQyuIPIkuDtzMgT8UC7FPQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85186abf-e12d-4dbf-147c-08d7cb9ecade
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:45:16.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcfHsoEuqRyEGs9GNybqZ079ocn/ZwdR04O/zxuDjQe9vOjXSCv3mMUrKbNMYqLvJZZRrM9KclhngyLuOTsA2gPW0UA6PNfPa0ziDNVjEuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0937
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: ltykernel@gmail.com <ltykernel@gmail.com>  Sent: Tuesday, March 17, 2=
020 6:25 AM
>=20
> Hyper-V expects guest only triggers crash enlightenment.
> The second crash notify will be ignored by Hyper-V.
>=20
> Current code may trigger crash enlightenment during system
> panic twice.
> 1) The enlightenment is triggered in hyperv_panic/die_event()
> via hyperv_report_panic().
> 2) hv_kmsg_dump() reports kmsg to host via hyperv_report_panic_msg().
>=20
> Fix it. If kmsg dump is registered successfully, just report
> kmsg via hyperv_report_panic_msg() and not report register values
> via hyperv_report_panic().

Suggested wording improvements:

When a guest VM panics, Hyper-V should be notified only once via the
crash synthetic MSRs.  Current Linux code might write these crash MSRs
twice during a system panic:
1) hyperv_panic/die_event() calling hyperv_report_panic()
2) hv_kmsg_dump() calling hyperv_report_panic_msg()

Fix this by not calling hyperv_report_panic() if a kmsg dump has been
successfully registered.  The notification will happen later via
hyperv_report_panic_msg().

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b043efea092a..1787d6246251 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -55,7 +55,12 @@ static int hyperv_panic_event(struct notifier_block *n=
b, unsigned
> long val,
>=20
>  	vmbus_initiate_unload(true);
>=20
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +	/*
> +	 * Crash notify only can be triggered once. If crash notify
> +	 * message is available, just report kmsg to crash buffer.
> +	 */
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
> +	    && !hv_panic_page) {
>  		regs =3D current_pt_regs();
>  		hyperv_report_panic(regs, val);
>  	}
> @@ -68,7 +73,12 @@ static int hyperv_die_event(struct notifier_block *nb,=
 unsigned long
> val,
>  	struct die_args *die =3D (struct die_args *)args;
>  	struct pt_regs *regs =3D die->regs;
>=20
> -	hyperv_report_panic(regs, val);
> +	/*
> +	 * Crash notify only can be triggered once. If crash notify
> +	 * message is available, just report kmsg to crash buffer.
> +	 */
> +	if (!hv_panic_page)
> +		hyperv_report_panic(regs, val);
>  	return NOTIFY_DONE;
>  }
>=20
> --
> 2.14.5

