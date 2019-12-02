Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9410F361
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2019 00:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBXaE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Dec 2019 18:30:04 -0500
Received: from mail-eopbgr1320112.outbound.protection.outlook.com ([40.107.132.112]:8315
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfLBXaE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Dec 2019 18:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiMnzVxyvOc8y4C+PO9lRFhKbbZpJLbF+C+0my3n6yVm13Uq0O5zKJPfutZzudzzQrJcV+JXb0Pz1kG6f1RP/s1eONkri6M3m4SNsWF8YXgps8gf9gIHp69AUScmUlePwJwLEm7lNPq0UEbDPY4hMbzIIYWTqoSbnREI2Q3CGfW6phXWQyzQfpyfmls09DfmLG/wj0tBnOfMn7JusWHgH/W/gkkPrScEeV4oINdLaHRcF868nP8+gt9hUI6EED1Fpf2gsbEgDEQsUW/JghFcTP/N9d5w7z9ohjcnmuHJPgA0jK7G7wV++id46zaNcTOiQEQB7E/a9bObLURnCVMvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GlB/Q2Pc83KGER82Oh+239+g4OXTN/13jq6hvxh0vo=;
 b=jPGtcgXNq4jmIzE7bDuRYixhNtn8hToDFPMTIdFBJKvtlsh18GXRLNUQ1PaZcjV9qSp9jAGYtX3tOiAIibOVyoTQ4+dw8ltlNSSjk+gvbDcQbd4Lpe1I934RVlcKR8j9ITWwib/G6ot4/Ir8vZA+PJ0u1Hd3OdvqQerOflzfXljo8ZkGyFHyEbw2LOYBWj8KhQMHJULvP+UvekWvOxUb9wRNETED/1bFU4x8Tcuod3brR7rrYnAAtyFuswIxc6/2tLZR63DCnDLA+oI2e0SwZCwBTCOGsETyN30spFkTn8fk+l5RK03TZxp+l+JoBzH65Dd8M5TJO0sknyfcXg4+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GlB/Q2Pc83KGER82Oh+239+g4OXTN/13jq6hvxh0vo=;
 b=j0oTeSPIzevtEBM6wvcvfEpKaMZZTHFH4tABYq/v9r0AGl+o7pZSKDrnI6w1o67Q42/gOkJO8nMpzIKvripE8Wtd/uql4k5+J/Rw6WfC9AcoAYlzkh6OBO78T0kEwh+4kv2iktKXf7uDwcPpLrqzg0fSxBi7mzgkndFm7YSUwtk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.3; Mon, 2 Dec 2019 23:29:13 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2538.000; Mon, 2 Dec 2019
 23:29:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVoaFgjOtcMfD6iE6p9Y6zUQz9k6enVJCA
Date:   Mon, 2 Dec 2019 23:29:13 +0000
Message-ID: <PU1P153MB016971582C7371E29065D83DBF430@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-02T23:29:11.3940351Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c6971509-4c17-459c-8ca4-1b8fc6fe4e74;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:8f1:d9c8:629b:7ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5282433-6b26-490c-7cab-08d7777f70e5
x-ms-traffictypediagnostic: PU1P153MB0154:|PU1P153MB0154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0154069993BEF2E7B344919EBF430@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(446003)(6116002)(305945005)(25786009)(2501003)(229853002)(76116006)(86362001)(4326008)(64756008)(52536014)(7736002)(66556008)(10290500003)(66446008)(66946007)(8936002)(2201001)(8990500004)(66476007)(478600001)(81166006)(81156014)(14454004)(10090500001)(74316002)(1511001)(33656002)(11346002)(316002)(46003)(256004)(14444005)(8676002)(5660300002)(102836004)(6506007)(110136005)(7696005)(6436002)(9686003)(2906002)(76176011)(99286004)(6246003)(186003)(71200400001)(55016002)(71190400001)(107886003)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ycpNH3RXTKuIkyHwbxThuhnOie4MIi70GCb5+/hBUvgJ83I8mQy441dWSjTqLcJ59hSSOQ6H6kI47ibsNugtWT0Mr7vHaeMk3MLXO2U4VaW0EX/u/f/D8m71to1fbX/bTr7H2xHCmfDcAIHZLeFl3oRJd2Ej6CYTSVoeep33j4uiYPaCp7TUDqyssHDHfWjT+p5fLL1UvD7mAL5WGX0IkrhY3xQXOlWK9zqBhxpwCTrB3e8xss6PtfuMxawUKreGbo1f+xQt7IbJnBSuT6Nh2il9fQWqVn2Q0P4bH2C//FvaKOz9ZDWV2dSBbYlWOX9LohFnl9OFMKHxWs/s5LL/TTERxUe+59eRaR74V9iMlEGRjb/B590fWhfJowqugeHfDEzaDRh+dyEdA1Au4IH/tQClegVMbzUxvUsN/vJk0WQAXFs+fuEuYx9VQY645h7/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5282433-6b26-490c-7cab-08d7777f70e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 23:29:13.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZAD14LaoVIubD4dM4TkbPMYOwDLZYL7x5eosEjZylUvQ8eVdV6gkwTuD//tfy3RskDRMJcfJhE05g8SJWVsqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> Sent: Friday, November 22, 2019 5:57 PM
> ...=20
> +struct hv_pcidev_description {
> +	u16	v_id;	/* vendor ID */
> +	u16	d_id;	/* device ID */
> +	u8	rev;
> +	u8	prog_intf;
> +	u8	subclass;
> +	u8	base_class;
> +	u32	subsystem_id;
> +	union win_slot_encoding win_slot;

Change the spact to a TAB? :-)

>  /**
> - * hv_pci_devices_present() - Handles list of new children
> + * hv_pci_start_relations_work() - Queue work to start device discovery
>   * @hbus:	Root PCI bus, as understood by this driver
> - * @relations:	Packet from host listing children
> + * @dr:		The list of children returned from host
>   *
> - * This function is invoked whenever a new list of devices for
> - * this bus appears.
> + * Return:  0 on success, 1 on failure
>   */

Usually we return a negative value upon error, if possible.

> -static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
> -				   struct pci_bus_relations *relations)
> +static int hv_pci_start_relations_work(struct hv_pcibus_device *hbus,
> +				       struct hv_dr_state *dr)
>  {
> -	struct hv_dr_state *dr;
>  	struct hv_dr_work *dr_wrk;
> -	unsigned long flags;
>  	bool pending_dr;
> +	unsigned long flags;
>=20
>  	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
>  	if (!dr_wrk)
> -		return;
> -
> -	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
> -		     (sizeof(struct pci_function_description) *
> -		      (relations->device_count)), GFP_NOWAIT);
> -	if (!dr)  {
> -		kfree(dr_wrk);
> -		return;
> -	}
> +		return 1;

How about "return -ENOMEM;" ?
=20
> @@ -3018,7 +3055,7 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
>  		struct pci_packet teardown_packet;
>  		u8 buffer[sizeof(struct pci_message)];
>  	} pkt;
> -	struct pci_bus_relations relations;
> +	struct hv_dr_state *dr;
>  	struct hv_pci_compl comp_pkt;
>  	int ret;
>=20
> @@ -3030,8 +3067,9 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
>  		return;
>=20
>  	/* Delete any children which might still exist. */
> -	memset(&relations, 0, sizeof(relations));
> -	hv_pci_devices_present(hbus, &relations);
> +	dr =3D kzalloc(sizeof(*dr), GFP_ATOMIC);

Here we are in a process context, so GFP_KERNEL is preferred.

> +	if (dr && hv_pci_start_relations_work(hbus, dr))
> +		kfree(dr);

Thanks,
-- Dexuan
