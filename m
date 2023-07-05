Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAE7482BE
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jul 2023 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGELMB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jul 2023 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGELL7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jul 2023 07:11:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB09FB;
        Wed,  5 Jul 2023 04:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaBzBS+cupXSQkT8YJWzVV/EKif6Crzbo9ijDMp59KLlVpEfBJXJ4Td+5tmvZvkrr9djUszC4SicgOPdX9gVU/xXuCwurz0SoMCnrLjDaEZg9+ek7z8iyJ2tbO8miol/fRWuvCAmrXXakPwmld4UnHs6ckBZHoEO9g3oBcHCc9iLZAK4lZWrnKlgHuQTxZ3/JEhojbEs39BRPak5paJzQ59OCZ68JLVpSvtWEQBNmu/ejtqJPvhXSQBNV/TIqRy32qN7YRMEC46adE6PANnQzVNYQNCafbglyLXU+lZMAv/QPYE2P9PnSC5zKzniLizc6diZ9QddiJmfcLCPHaD3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skGy+4FptqkCmcZIUKlCnhnIPZW4fgWGT8MSi7SIw/w=;
 b=cvpaw17cQbGQVaGxcgRg03RBND0i0fn0/DmFvysw/y1s4wUG8eweqpQJ75lhe1E4fxt/REf8I7hjMPqT3dWGe5ibjk+F+k5Gk/JxdqkaZOQRK0e42vq7wfN5MyzyE/2xTwscd+fkboCCKDmbLXcAgQ29LacHVMe7QpCcMsZmwDamsJW6i/H7ioJGa0KR6kCUrfDn43ZziZfTeIRtrF7Tx4/fWTJlgLdJvDVD4y4acdDifPqumJ4P+rjZUbvgkHeRraJywNxpUhZb40LH34BL37Nvpd/femf9ioArslzG+f/n1Pkqit/xSRHXFXwRLJ4jchUWnuxPdgn6LlGAw0mRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skGy+4FptqkCmcZIUKlCnhnIPZW4fgWGT8MSi7SIw/w=;
 b=Z0dRkgfyUGW3OVMoLu3ahhYpl+RdgzJ8MBCfAcx10st6eMJw/VvC6nuXfx89bxPljCsYzfMSt38NGr7BVFTh1lwZN8qr1QJ75Ckfa1U+keUg0ME5IaD9ehN4yJ2WuZ7sT31x98ZP8vkC/z4M1iRw52PoMThYIEMPsRIa5ZFX28g=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYZP153MB0737.APCP153.PROD.OUTLOOK.COM (2603:1096:400:261::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.4; Wed, 5 Jul 2023 11:11:51 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::5d43:697d:e190:459a]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::5d43:697d:e190:459a%6]) with mapi id 15.20.6588.001; Wed, 5 Jul 2023
 11:11:51 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH net] net: mana: Configure hwc timeout from hardware
Thread-Topic: [PATCH net] net: mana: Configure hwc timeout from hardware
Thread-Index: AQHZryO3JEZdMLEr90SGTMj96qIpya+rBF5w
Date:   Wed, 5 Jul 2023 11:11:50 +0000
Message-ID: <PUZP153MB074909725BED8C12720CFE3EBE2FA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1688549578-12906-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1688549578-12906-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8418f209-9adb-4c4c-9611-5f0e3c5b10fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-05T11:10:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYZP153MB0737:EE_
x-ms-office365-filtering-correlation-id: 58d5eb84-768f-4386-aee9-08db7d48a1ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEP5Kt/gWXAzi54q4sd2Qu0Xk/hbk3s/ESAH89yKgudAdXkI8IHeDEHNPt9OvqVvRGLdJSwBHlNOjlHZgJUGAb8SU9BoSHUicRgZjipaxkjc8mppxs89RYAjxRl1immhk8xCNbudinA2DsCOF0Hhp/uKGNU/znaCie2U1T1kD7JCsRDRMty4kEuM8q1rdFdYBoXHCbT/IiPfHulWhoEnDkynUegtmLeh6mLrLIw2JPkQxuJbY8PzHrBePZK1ABxXNl8Smp93Fi6r1mLYKKdBr+eDliLlZctCeyJkTrTd9wWaKKQQC41B9ZAbMXoYFl0AvW+ANza8YAs2OXVltF6q1b0jBGDQYCF9oFAfiO5c4oLlOXn0725B1mauj9q+UIPjA0Cm3vLNfYW+PSC76vMbQVWAN+fLjENe5vNHGv110s3kb8mfMBv8Ous7SNnfDVJil3xL93Y2AxTQwQGZ8enkxZ7aXzZ6ocNJG+iCvtekXfYrm3+WVvsIGwv6wWtNckx9BHzix2KroPNaEDUJy05VxDIKdblH1HWGoqFMDfizAuCBaYEUtOAom1KAdeiwwQa5TIXaKUXr6cGNZ5STxkhZ4mQi84Uw6rEvHOMavD38xyyQuHH/FdzrpYsBJXbUtdx4ZYw3tE+xejeZYq18B02an+65O2DAmbDRMtq20dZ/06WgaDm9A+IssK7A1tUkyRwI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(186003)(41300700001)(7696005)(38100700002)(107886003)(82950400001)(82960400001)(921005)(53546011)(71200400001)(6506007)(122000001)(83380400001)(9686003)(55016003)(8990500004)(38070700005)(86362001)(54906003)(110136005)(478600001)(10290500003)(316002)(2906002)(66556008)(64756008)(66946007)(4326008)(66476007)(76116006)(8936002)(8676002)(66446008)(33656002)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j49Akznba3Z8wFrPWiOuez0d4+nFOPfLGx9W7yqZIF3MqYbp744P3BIvrmaq?=
 =?us-ascii?Q?1FiM8mpAAwdpVrGpwQpSX7JreS8WdU3TkyTXgts/wBi7RH7hIqZC/eKwYDjN?=
 =?us-ascii?Q?13c97o9A02QB48mNL9Udzk6pxsoRA80ef5csrM/gqlzcVvoGl64dQcXCVV6U?=
 =?us-ascii?Q?LEBQqRi8wDaGPS/S545Wx3m5kuhxwl7/JtyRVgIjE29L+Rw53q1vaxCnFUYj?=
 =?us-ascii?Q?TcmX3gj7O7HOtVNou6LcWa4WxMwL1r/CPWwZXiUOzSvqRX6U80pBgJ2QVQ2a?=
 =?us-ascii?Q?w0h3KfivCRfSLD9oqRii6wGL8BjACnvmumu/IRl2Zr1SsMiREtYT0KttKVQm?=
 =?us-ascii?Q?4SKeSv9G874rvCxJIR/To6QSOLzLz8lX2Z22C49lRrZpz8LL3CVHsO7P54/d?=
 =?us-ascii?Q?ULsW7P9th2O7TToylm0FrLYhV8m/DyHiLBt89k2bjB1eu6CwSlckhJJ/2R8u?=
 =?us-ascii?Q?uKnevcYynz7yg711putgl9srqJXxLyQGQLcndmNbTK5slKzzaqtl5Mjy/leS?=
 =?us-ascii?Q?07/VqLxviLdbzTpWz50M47Y7g+z38933CkhKmC4OXZBjSxe6MPdn9OfuW14u?=
 =?us-ascii?Q?c7wnAYQnibrCEWeYt70PMISwU7RDlOcvyAaI4B7cIJbUnoy86+x4zPGGeHms?=
 =?us-ascii?Q?P+0gWnlrpz6lk+nme1AJiyRz6w2CAj8ljduUVvJuZxp5hY9dQBPFGYS1cFE6?=
 =?us-ascii?Q?qUzXQdWdcnrxQAAQzTOgk94rEK7gQlHCIqOq+BqB3CMGV2jkyuW7VzqE9oib?=
 =?us-ascii?Q?0eufbffsa9RU7+GYj9b9Khv2GrQOv5sEdCa7ZpjHfoH6Ds+zIUN0BUy/lJY3?=
 =?us-ascii?Q?puPMKnQ6UhvpWpPCO9szZSq7QOHzpz2g12bAKA1jhajjq1p2/FtpsG1AOYIA?=
 =?us-ascii?Q?OKxEDenXGgL2ijJETas5x2DSQ7LBNLnR5JeCErITGCw6UtrhGlRS9bQIoVmI?=
 =?us-ascii?Q?uu1+pCcF8g7QWF/XplUJWE8ZIVu96Ge7lIkG4dwsVNPJAmuHCuMOGTmWlmkr?=
 =?us-ascii?Q?3ksZoCEDtJCw9ADobENkeO23RTaaD9rInxulkKbnIT4WdheF3MT/OIlKoB0w?=
 =?us-ascii?Q?+34Mbnspg19dGD3omrNlD2tpjaEmwe/D6mSzACCDPDA/gcQ2kEknjYvE/XRL?=
 =?us-ascii?Q?GqsENnflZE8e4bcAS81pGvm99NSbxuVq4C/XdUz4+fiTZTDa1/K7QWOqDTMW?=
 =?us-ascii?Q?P6GnfjJh30PqysgY71lX5f1PDU3ZvIIfT92KT0LYSGhGEYc5AHHW7jM7Iqyg?=
 =?us-ascii?Q?CulYb1z43WWd86IZjaZhPRFpuxyuc2vjTXwbfasQBmy0R1HRgBwXiSk98Do9?=
 =?us-ascii?Q?5+//6nsWWS6BxemXbDwmIarYD7Qt81GKYmQCe1gCYxm5XNPpEil3QaZPI/1/?=
 =?us-ascii?Q?O79a1U7ouCEQEweLX6Yd3M3Z4FEJSx3TjxdJfmsK+f78a1ArC3FREYNqvtUR?=
 =?us-ascii?Q?Q+YVmh077XIHskvK14cBl4LEOp/cu83y6Qr0hENDeTYJUmprgB1Y7hOciAEH?=
 =?us-ascii?Q?bjEQhs00u5KeWq9ZtBbfTQQ2g2S0RqMIUyGXh4NZO4NKFL55fGS5LMasR3qV?=
 =?us-ascii?Q?bEcF+KRq706w+v5nflb2pxfc5BHJBEIDg9PvE5kz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d5eb84-768f-4386-aee9-08db7d48a1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 11:11:51.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUQMFe6n8xGQogJlnaH3YQx0+jEUiDbGWWWJka24EHoSEx/Sqe0yVUFlE5QQyM4oIWk874uVJcUHXcLhfCc5Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Wednesday, July 5, 2023 3:03 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
> Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
> vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: stable@vger.kernel.org; Souradeep Chakrabarti
> <schakrabarti@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>
> Subject: [PATCH net] net: mana: Configure hwc timeout from hardware
>=20
> At present hwc timeout value is a fixed value.
> This patch sets the hwc timeout from the hardware.
>=20
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 27 +++++++++++++++++++
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 ++++++++++++++++-
>  include/net/mana/gdma.h                       | 20 +++++++++++++-
>  include/net/mana/hw_channel.h                 |  5 ++++
>  4 files changed, 75 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8f3f78b68592..5d30347e0137 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -106,6 +106,30 @@ static int mana_gd_query_max_resources(struct
> pci_dev *pdev)
>  	return 0;
>  }
>=20
> +static int mana_gd_query_hwc_timeout(struct pci_dev *pdev, u32
> +*timeout_val) {
> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	struct gdma_query_hwc_timeout_req req =3D {};
> +	struct gdma_query_hwc_timeout_resp resp =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_HWC_TIMEOUT,
> +			     sizeof(req), sizeof(resp));
> +	req.timeout_ms =3D *timeout_val;
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp),
> &resp);
> +	if (err || resp.hdr.status) {
> +		dev_err(gc->dev, "Failed to query timeout: %d, 0x%x\n", err,
> +			resp.hdr.status);
> +		return err ? err : -EPROTO;
> +	}
> +
> +	*timeout_val =3D resp.timeout_ms;
> +	dev_info(gc->dev, "Successfully changed the timeout value %u\n",
> +		 *timeout_val);
> +
> +	return 0;
> +}
> +
>  static int mana_gd_detect_devices(struct pci_dev *pdev)  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev); @@ -879,6 +903,7
> @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>  	struct gdma_verify_ver_resp resp =3D {};
>  	struct gdma_verify_ver_req req =3D {};
> +	struct hw_channel_context *hwc =3D gc->hwc.driver_data;
>  	int err;
>=20
>  	mana_gd_init_req_hdr(&req.hdr,
> GDMA_VERIFY_VF_DRIVER_VERSION, @@ -907,6 +932,8 @@ int
> mana_gd_verify_vf_version(struct pci_dev *pdev)
>  			err, resp.hdr.status);
>  		return err ? err : -EPROTO;
>  	}
> +	if (resp.pf_cap_flags1 &
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
> +		mana_gd_query_hwc_timeout(pdev, &hwc->hwc_timeout);
>=20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 9d1507eba5b9..f5980c26fd09 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -174,7 +174,25 @@ static void mana_hwc_init_event_handler(void *ctx,
> struct gdma_queue *q_self,
>  		complete(&hwc->hwc_init_eqe_comp);
>  		break;
>=20
> +	case GDMA_EQE_HWC_SOC_RECONFIG_DATA:
> +		type_data.as_uint32 =3D event->details[0];
> +		type =3D type_data.type;
> +		val =3D type_data.value;
> +
> +		switch (type) {
> +		case HWC_DATA_CFG_HWC_TIMEOUT:
> +			hwc->hwc_timeout =3D val;
> +			break;
> +
> +		default:
> +			dev_warn(hwc->dev, "Received unknown reconfig
> type %u\n", type);
> +			break;
> +		}
> +
> +		break;
> +
>  	default:
> +		dev_warn(hwc->dev, "Received unknown gdma event %u\n",
> event->type);
>  		/* Ignore unknown events, which should never happen. */
>  		break;
>  	}
> @@ -704,6 +722,7 @@ int mana_hwc_create_channel(struct gdma_context
> *gc)
>  	gd->pdid =3D INVALID_PDID;
>  	gd->doorbell =3D INVALID_DOORBELL;
>=20
> +	hwc->hwc_timeout =3D
> HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS;
>  	/* mana_hwc_init_queues() only creates the required data structures,
>  	 * and doesn't touch the HWC device.
>  	 */
> @@ -770,6 +789,8 @@ void mana_hwc_destroy_channel(struct
> gdma_context *gc)
>  	hwc->gdma_dev->doorbell =3D INVALID_DOORBELL;
>  	hwc->gdma_dev->pdid =3D INVALID_PDID;
>=20
> +	hwc->hwc_timeout =3D 0;
> +
>  	kfree(hwc);
>  	gc->hwc.driver_data =3D NULL;
>  	gc->hwc.gdma_context =3D NULL;
> @@ -818,6 +839,7 @@ int mana_hwc_send_request(struct
> hw_channel_context *hwc, u32 req_len,
>  		dest_vrq =3D hwc->pf_dest_vrq_id;
>  		dest_vrcq =3D hwc->pf_dest_vrcq_id;
>  	}
> +	dev_err(hwc->dev, "HWC: timeout %u ms\n", hwc->hwc_timeout);

Can avoid dev_err here

>=20
>  	err =3D mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {
> @@ -825,7 +847,8 @@ int mana_hwc_send_request(struct
> hw_channel_context *hwc, u32 req_len,
>  		goto out;
>  	}
>=20
> -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> +	if (!wait_for_completion_timeout(&ctx->comp_event,
> +					 (hwc->hwc_timeout / 1000) * HZ)) {
>  		dev_err(hwc->dev, "HWC: Request timed out!\n");
>  		err =3D -ETIMEDOUT;
>  		goto out;
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 96c120160f15..88b6ef7ce1a6 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -33,6 +33,7 @@ enum gdma_request_type {
>  	GDMA_DESTROY_PD			=3D 30,
>  	GDMA_CREATE_MR			=3D 31,
>  	GDMA_DESTROY_MR			=3D 32,
> +	GDMA_QUERY_HWC_TIMEOUT		=3D 84, /* 0x54 */
>  };
>=20
>  #define GDMA_RESOURCE_DOORBELL_PAGE	27
> @@ -57,6 +58,8 @@ enum gdma_eqe_type {
>  	GDMA_EQE_HWC_INIT_EQ_ID_DB	=3D 129,
>  	GDMA_EQE_HWC_INIT_DATA		=3D 130,
>  	GDMA_EQE_HWC_INIT_DONE		=3D 131,
> +	GDMA_EQE_HWC_SOC_RECONFIG	=3D 132,
> +	GDMA_EQE_HWC_SOC_RECONFIG_DATA	=3D 133,
>  };
>=20
>  enum {
> @@ -531,10 +534,12 @@ enum {
>   * so the driver is able to reliably support features like busy_poll.
>   */
>  #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
> +#define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
>=20
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
> -	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX)
> +	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> +	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
>=20
>  #define GDMA_DRV_CAP_FLAGS2 0
>=20
> @@ -664,6 +669,19 @@ struct gdma_disable_queue_req {
>  	u32 alloc_res_id_on_creation;
>  }; /* HW DATA */
>=20
> +/* GDMA_QUERY_HWC_TIMEOUT */
> +struct gdma_query_hwc_timeout_req {
> +	struct gdma_req_hdr hdr;
> +	u32 timeout_ms;
> +	u32 reserved;
> +};
> +
> +struct gdma_query_hwc_timeout_resp {
> +	struct gdma_resp_hdr hdr;
> +	u32 timeout_ms;
> +	u32 reserved;
> +};
> +
>  enum atb_page_size {
>  	ATB_PAGE_SIZE_4K,
>  	ATB_PAGE_SIZE_8K,
> diff --git a/include/net/mana/hw_channel.h
> b/include/net/mana/hw_channel.h index 6a757a6e2732..3d3b5c881bc1
> 100644
> --- a/include/net/mana/hw_channel.h
> +++ b/include/net/mana/hw_channel.h
> @@ -23,6 +23,10 @@
>  #define HWC_INIT_DATA_PF_DEST_RQ_ID	10
>  #define HWC_INIT_DATA_PF_DEST_CQ_ID	11
>=20
> +#define HWC_DATA_CFG_HWC_TIMEOUT 1
> +
> +#define HW_CHANNEL_WAIT_RESOURCE_TIMEOUT_MS 30000
> +
>  /* Structures labeled with "HW DATA" are exchanged with the hardware. Al=
l
> of
>   * them are naturally aligned and hence don't need __packed.
>   */
> @@ -182,6 +186,7 @@ struct hw_channel_context {
>=20
>  	u32 pf_dest_vrq_id;
>  	u32 pf_dest_vrcq_id;
> +	u32 hwc_timeout;
>=20
>  	struct hwc_caller_ctx *caller_ctx;
>  };
> --
> 2.34.1

