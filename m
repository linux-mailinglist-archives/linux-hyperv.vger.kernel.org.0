Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD47F367162
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Apr 2021 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhDUReF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 13:34:05 -0400
Received: from mail-mw2nam10on2119.outbound.protection.outlook.com ([40.107.94.119]:32321
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239822AbhDUReE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 13:34:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtN+8Yk7u/bsw8MC9fwmEbdeoq+pCocpnheTnN7RpePI85cmBdpxFwU6jz98CnUh8EOfqzOjEbYXPhA3aLVcymltiRNEKRCLmx0o5auEJo0BXI6bgpZi+VEBwOR9deWQTik2a3kiwYEJaE4TbjqNhN4jo1zCXDMKCrPBOGPYHM4A910RAu3Bgy088i+NWIBs2OJFa9seApc24U9jRWZELDfUWa8D3/beIvmEt3QZssDHsPENVCl5w81cFbwYWzqBSsrgBQFzhNae4f7Iak5ix8QwVEBJcCSlZy+6uuTdLPh2EgfMIIU+uKRCa2Rzso8vjAi1wXhBaeddf+vUDYpnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIaA5h2arZwGRXuP7WWy47PiFdDmhN5OqlHH5rrfjjk=;
 b=M0yX4D4NmIcC6bMgucGgvFzUciYjthDTXy7/nGOmO1lgmGthNC53oEa7lZUNAwszxlb90dk+FREA9FaodW7ZMjl/Ii+2qt6jMumgUjhxIBwohCxP5SShYc9T0xrReJAVeDMGcV9ntXXt4Z8AmMAeUd0vTovqziACifnQTXKrUFUmfzojirv6XbOctLSZfY3u14LyttV1lYPKsNvLfFd8fZOKwkTSMKsiKg48zwFOSV4n8zCI6/49R4/FjfkQCucQcu7KorzMb1cKu4AOO4CqAPrhYLzkxDij6axJwdyf3J8fD5gK5+GhTVSH28r245n0YsgFVxL2IxnIH+Cb5WnMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIaA5h2arZwGRXuP7WWy47PiFdDmhN5OqlHH5rrfjjk=;
 b=DJOqaKF/RcTi7eNYhZ4uEQXvlHQ1wvmZYYgMKvXd29KHtr9SiLrUx6SyLNXCHD/ZT/TvH+5Rk32SFRRqksP0TrZDgMLszRVe9n7/GmwNz5JKg3H1Y8gEtyq2lL6DMk+C/qZt2hRNlm/qh40WoheFyLfDGFqqhtJX7T68pQ1yRG8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0477.namprd21.prod.outlook.com (2603:10b6:300:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.10; Wed, 21 Apr
 2021 17:33:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%5]) with mapi id 15.20.4087.016; Wed, 21 Apr 2021
 17:33:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Topic: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Index: AQHXNVHtsv1pPhn/lUymN/4kjb1Ps6q/O9jQ
Date:   Wed, 21 Apr 2021 17:33:29 +0000
Message-ID: <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c2cd82d-a9ce-4184-9a5b-6c1855cc9093;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-21T17:24:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [75.104.93.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 530ced51-da83-425b-abef-08d904eb9440
x-ms-traffictypediagnostic: MWHPR21MB0477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB047749C92D59B76EB2A84962D7479@MWHPR21MB0477.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJPxflBkWy+ZSRIaowK4XsUXQughcKxSqiHkeQhuy2RRvOEOlOUXXNmMXCmpZW3y+WEPyecpSlATQy94EaHYKjtzbPD+8+a69VkEWJoHJM5Uft4rCZAesn/QvKD8ihdR10XSFPsTPkhrYCuYOTDz6Xkz8JS91epRozNY9d+SYW9a7iCpXQMWFEElzUPbbBMXrlTLUZidjaupuTTeoDDvqyeynWn5SBLleFT0xQolD8C5W1pJLf/IrU3+9kT0l+7oPcYwwLnmsFEqqsI3MF9U9FzWjrXUVOmC9GBWUVB2H6NmL3zmrnXL+k6sl0dgXMq5xIFqP70zoTw1QeV2W8LVQ2yY+bEw5rYNzaQkCsTNlpPeSBeu1AS0vFw/CPHv6DTlzbhlShRwoUqRPnXwe+mPJXFTXVk3fZRvxU5mWE/0CpCyWIX9nHhaIZ+LHBtU37/axB6QMUC1fUXTVNKN31stp9+RyNB+e3GAciwBk+XMIMYaqZ0WWV/3PUEPREQ4cZonKYDpAvKN3FDnjr/APpZa50l7Pp7CXYcapAXsidXnPZbJU6E+E5lThctY2EcXA/OYeophI2xk3YYNNFBv1rUtkXcAkaxgYt0sTY3aI6MYcrsoLS1KR5Leemwx2I8MvKR71EW8WFpq5ZfvMXAb23ok4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6506007)(110136005)(26005)(186003)(478600001)(6636002)(316002)(8936002)(10290500003)(82950400001)(8990500004)(7696005)(9686003)(8676002)(55016002)(52536014)(76116006)(83380400001)(921005)(38100700002)(2906002)(4326008)(107886003)(82960400001)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(86362001)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PMQIs0D1SuEwunDLDLIs6ULvrvSdwaFdiZsl8AAe+p0u6U58qMDe5V5+lcm0?=
 =?us-ascii?Q?9gxk1gtHzFAhRMR34b/JO9WeToU1Zrxje00jWvd/tJjLzlkJ7n0QS96o1phL?=
 =?us-ascii?Q?LyxuK+oo1Sn93mhl5wRhtHil3+WkL4I5bm7Jr4cppZeyAZoA7TW2BoCFPsnC?=
 =?us-ascii?Q?WsRrQd45Mk9djHfNv2PIuRVJuwlOP64vOZqVTLMcsYvaIvH4LdEU/kQgHqZz?=
 =?us-ascii?Q?dYGCyK/8WHE1nzJ+07HOD4GdSbNN2OEeRz+Zuh1FMtK+u6qN6X2oRG9rmxhT?=
 =?us-ascii?Q?90Dba4Uu3kymGqcWJv5cyhXE0dlsFJVLstB8lkcUqisPMvfWY5qvQiRojMmN?=
 =?us-ascii?Q?xd/vPbFKCc1BQ07gt6w+7+32x//4A6l5qEJ4J0k8NhazbEyNZiOhPrNFcbU1?=
 =?us-ascii?Q?svfVmflcezYJBZm+hBTk20B06i+R73AIOxD4hiKj049JJAOarfe8HlMRJ4jt?=
 =?us-ascii?Q?Q3AG5Ct5Yq6zUQ1ZDRnAiaDBLYrcszWgQbiZoNiYfy1BpIF/4wEFEFbIBsRl?=
 =?us-ascii?Q?9EARFl1rCzTnMRYDFH1wnYnE9aBBmRz+ErUAB9uZjUb9BppTQVEgd3UszLuk?=
 =?us-ascii?Q?pX+doXFJUwzOGnbOK56/ISvjISflDSPDNYnd+2UhHtP6k4TKNcG+nU0esU12?=
 =?us-ascii?Q?nFDDVor0eYXWiThjT42GWBGQNUbHHf3QVCiJbuBdUVldzv42HQm45Lf4wHLo?=
 =?us-ascii?Q?b7netdRMmEtNflJVec3URaf8QZebF7KcR1eC4XfcitUA0xwr+l4k/CwodEoq?=
 =?us-ascii?Q?9ewApSzXEj4A38aRmG188Z7f402oWd/aaigeXdaVsRRW65Gb11yr3wQqpoHQ?=
 =?us-ascii?Q?GBXWtqsaS9XOv65zGRdNV5qeT5RQ56GiQzjqVfSpHU0pYegXdMl8XWFfjTsX?=
 =?us-ascii?Q?D5DlnjPYz36d0DjzQ4uRv8m1+OR/I5oNAM8deesvdkJ+du7s6pJeK4NqByNm?=
 =?us-ascii?Q?Tgk9TbDObbIZ5XcHf2r77WX63aoBsJmGybVJ5J57mmxuJIl8PJY8QQgRhmMT?=
 =?us-ascii?Q?vkrQuptD523boipsJCcsRn0+lBEsGsYfSitA3if/ESAHiRTwOnHAjXKHoio0?=
 =?us-ascii?Q?qY1teAmihtNKUwb8pRr27kXAyxrMjL1zWWMyt1h5ZOFhSv7ycCqSStvAyHKf?=
 =?us-ascii?Q?N0FHOay1e1hld0Ng5ufynj8UARDKwBG+fYg7a/OBE//U2VZeQjfu+Uch/b2U?=
 =?us-ascii?Q?uCYqnHF4neyLY4Fdr/iE5TsstzVeezuE0/nMnk1af4tdgVhlNqZZ+gugbfCe?=
 =?us-ascii?Q?MtPJaU861AU/vUQhXcQtnNuKyiHezKVTQdSfJhPUEro3Jy9d9KDKFz6KoTZw?=
 =?us-ascii?Q?W1ssEhXyLIV1u9cJWwrlG96F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530ced51-da83-425b-abef-08d904eb9440
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 17:33:29.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4Ca54nd67u0NNrxISrZsOcekgVUzAiTPjO6ti65CyXSczwOntva5vM6hKTZcNnAix2NS2BvVOM/jk4Xqfsi8Hn65mzhpVYwRgRBECEFvgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0477
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>  Sent: Monday, Ap=
ril 19, 2021 12:21 PM
>=20
> On removing the device, any work item (hv_pci_devices_present() or
> hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be runni=
ng
> and race with hv_pci_remove().
>=20
> This can happen because the host may send PCI_EJECT or PCI_BUS_RELATIONS(=
2)
> and decide to rescind the channel immediately after that.
>=20
> Fix this by flushing/stopping the workqueue of hbus before doing hbus rem=
ove.

I can see that this change follows the same pattern as in hv_pci_suspend().=
   The
comments there give a full explanation of the issue and the solution.  But
interestingly, the current code also has a reference count mechanism on
the hbus.  And code near the end of hv_pci_remove() decrements the referenc=
e
count and then waits for all users to finish before destroying the workqueu=
e.
With this change, is this reference counting mechanism still needed?   If t=
he
workqueue has already been emptied, it seems like the wait_for_completion()
near the end of hv_pci_remove() would never be waiting for anything.  It ma=
kes
me wonder if moving the reference count checking code from near the end of
hv_pci_remove() up to near the beginning would solve the problem as well
(and maybe in hv_pci_suspend also?).

Michael=20

>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 27a17a1e4a7c..116815404313 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3305,6 +3305,17 @@ static int hv_pci_remove(struct hv_device *hdev)
>=20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> +		tasklet_disable(&hdev->channel->callback_event);
> +		hbus->state =3D hv_pcibus_removing;
> +		tasklet_enable(&hdev->channel->callback_event);
> +
> +		flush_workqueue(hbus->wq);
> +		/*
> +		 * At this point, no work is running or can be scheduled
> +		 * on hbus-wq. We can't race with hv_pci_devices_present()
> +		 * or hv_pci_eject_device(), it's safe to proceed.
> +		 */
> +
>  		/* Remove the bus from PCI's point of view. */
>  		pci_lock_rescan_remove();
>  		pci_stop_root_bus(hbus->pci_bus);
> --
> 2.27.0

