Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F74DE6D2
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Mar 2022 08:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiCSHss (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 19 Mar 2022 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiCSHsr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 19 Mar 2022 03:48:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2A2E4173;
        Sat, 19 Mar 2022 00:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5gD9TYPZpexq4yZqLD0RgfRoEaVYaVzbVCJvbtu9V9c+SCo/US3sSCH2ev//Zh3no3lZBJZn0AhyC9Zwd2o0qA7Liq+YAMlwzPVydyHrdskYROlCDUTtzIyBsOMhGpCM1RBTeEB6JJT+t24jfIizfc/pF3IrbBrVDd8Wu8ShVyNbVIlQZZKLu4+Q+1yd+5TTAesfXxoXdI3G1hNg3lram8w2EuuqEMi6Jd79UpyLDf1HlIyD196vr8TTsEkv1LJgsAl6ldEJdWn08Hs0H6EyRZBznAaYLNGB4YLHBEUfWxd2m5UsZVDobN6haVCwZUyR5TY8sgg3SOvLt4YuXtl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET+csLmSfPbu8SCQi36OPgUlT/AAhPDnefqiQBYJT04=;
 b=My5xWf2KxSjSGXsVadH0Hg9JMzWaUauMl1ZfiLWN+u5I3hySJ/cFDbuC/nZU3Bre9XsGiUuluZYM/q0lMHmrAaN9bUHs9BqWWU0wlQl0wLjTv0apaqaAxYrI88Gxb2vau10wd8gaKKrEI8y8vMcHFGUniL91Xc7eST4bmnT8ZvDIrth0/Nss6oIu+Mj6MK9L+/MQa6Sk5Uo6SdX258sg9VUb6WFJcY6Vd64qPFuMLhUye6tpOdsECRd07AEZV/vZyZ25KCHWPaS20jlQA8qrkAVQv1wGvm/tnwhUPtDvtjPNzb9Fi8163kiNXigH0P8JBwj/nYLaH6BouFxYB+qlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET+csLmSfPbu8SCQi36OPgUlT/AAhPDnefqiQBYJT04=;
 b=QqzDSEw40kq6oH9+qxbRUeZ85yKsNR7yr5er+COTUxprxIqyt57GgviVC+TtBcb8KldpTmiSgmEw5xNNFtdRdqM+h/yrYkZynizg5ihjLBOyJfeGJPnXMWudznpdAzRB9rWApJ4X5Se6mWwsL2jBN2Xsgr9bUgECRyhNW8+rsA8=
Received: from KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM (2603:1096:820:11::20)
 by SG2P153MB0109.APCP153.PROD.OUTLOOK.COM (2603:1096:3:19::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.7; Sat, 19 Mar 2022 07:47:21 +0000
Received: from KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM
 ([fe80::45e1:56b5:9142:7517]) by KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM
 ([fe80::45e1:56b5:9142:7517%4]) with mapi id 15.20.5102.008; Sat, 19 Mar 2022
 07:47:21 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transaction
 IDs for VMBus hardening
Thread-Topic: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transaction
 IDs for VMBus hardening
Thread-Index: AQHYOvCC7YdFpbE8V0SVWDhoYbPEO6zGVFZw
Date:   Sat, 19 Mar 2022 07:47:20 +0000
Message-ID: <KL1P15301MB0295879FF28B67F3C521FFB3BE149@KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM>
References: <20220318174848.290621-1-parri.andrea@gmail.com>
 <20220318174848.290621-2-parri.andrea@gmail.com>
In-Reply-To: <20220318174848.290621-2-parri.andrea@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f716056b-3f87-4d1a-828f-f2691c62bafa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-19T07:44:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20f2c119-3b3c-4b04-4827-08da097cb332
x-ms-traffictypediagnostic: SG2P153MB0109:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SG2P153MB0109504813788487DAD34115BE149@SG2P153MB0109.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leFIn6tvL0diVXmq3GRxuEvF3iBjHj7OBZ9vARVL0nwa4uchnIOnszNPdP3jFUHMsCSD66p37u+3pZ/MNdx+UQTuS+YSnR46jiU3pOP6pq+GRoMsFU/IRxLVjHfDq6iqdGx2EMxFMiLVjyHUAakrQwfKNLrRBIrIVRZlOycQqMmGLwsE8LN4zvNiU5tH2tHLf7VHhHIdCQcOfGl3o2KrY4WKLq45bg+xYsk4C/NS+u/fDHBYKvhkALWZPRArUC06G0xUgkFfoGUKOf7L0TtDWzl/mbaxLCazpwon/5kf7qPoooXkcJwmLZjKstj9B9/CiSlzR9kQyYnePXXr4VzEuJuZa8JLVdk1Zhd5CipSFoqO6lecXub6CKAUGUUlWZXIiDmZudTq83Un206CqUi0G6zNDT3zlZ80WHTp9B+ggT1vDf8WRyJLPt+2Ru8qpYrykHI6DiHc3omC7nd748EZOZ7Y28Mr6AO9Nf7iDocynEbLB2PIQxUiqvHKX0sO0sp65547+39TFcXLC6movu3voruGIkSvb1+AquQcey7Vmi03BlgRlP2fsCcQWXWAujLRGfB1PdasApk09bnoOC1qARGmdIa7Ms549oD+kFE4ye+aDOigUH+up8Hmv+tiW1SmBW7CsMW4bmiog9ihVeDPM3aPuqwEFo4bxVcKNH42kZUnqm+eonKBQdGz4v6BC8kmrvsFhQGMNj373oyLnL2Gryn2TlwmY4vFcw1ouMnUA4a0V6lks0SIV4cocYtnEnixK5VhOvAd2+Nh1ACvnw/wlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(110136005)(54906003)(71200400001)(10290500003)(6506007)(7696005)(508600001)(186003)(26005)(66476007)(66446008)(9686003)(64756008)(66556008)(4326008)(83380400001)(8676002)(33656002)(66946007)(76116006)(921005)(316002)(5660300002)(55016003)(38070700005)(2906002)(8936002)(82960400001)(82950400001)(53546011)(86362001)(8990500004)(30864003)(38100700002)(122000001)(52536014)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BXXHc/xWXRRmbKLkR6Ru4AqAZhkWYB9P4DeSUnHTXYdGng+Dok8Jir2UPBiW?=
 =?us-ascii?Q?TTWOC1TrGwulV+bj7j2XrAAyBB4yWyAwGMIOMouGKqAYulH9LH989pFthjFc?=
 =?us-ascii?Q?7WFGGA/7h4fBMPMiILnDDkfPMOSSeXK+OwJ+4kVAnZh6j2IAXLXAyqQvDVBS?=
 =?us-ascii?Q?J8wWfMPmKg6fiLQQwQY8mBfcqfywYwrzLDkdIWVTrR3jPclWkD3wK+zSoPJX?=
 =?us-ascii?Q?5uUl9zw2pOWGNucFVM6mXTKCWc7nPGOGb1nIeA90MZyrSezTQy5TzBAP4JiR?=
 =?us-ascii?Q?bejnLrbwWrUW7opLZ5a+crD5DgBRIhsIEHp2vPmDpE31+BdhHuqBmQZ4RB7m?=
 =?us-ascii?Q?QnQlUM6vYmrKCa6/gRkzJ7+FeKIXf3DsAaXVEOKXYIksH8HHco7leWQv1s9G?=
 =?us-ascii?Q?NyjpV/2sqeCIa7S5baB+zMHTQwNFFQjL+6A/Rws6dwpM+1qWKxYT8I3YdYpY?=
 =?us-ascii?Q?ORJ2M7uhSm32UeUE16O1CpftwbLWTF1IkqQj1UKTW5MVevUOUTk2CX1/X0zy?=
 =?us-ascii?Q?W/WjiMUNxQzUCn2qfQfdUmKYa30uGCKtN9SIYjdrOsMAoGTnWXVovYKSWJxl?=
 =?us-ascii?Q?s3Grss9W4Wj/FcguzRKdtYh/CXdRZERoZ2gFwnUyYzZnsYubhBrWBhKu3EQ8?=
 =?us-ascii?Q?ftJcvQ0QCfMnEayK4Gf71UYSdT0spueDIeIcWZYtSKkpiQiKQlo7BKROywfE?=
 =?us-ascii?Q?zybLOLdm9MElDmYS0gHK1k4J8mqWOF/twSsM0g7Vny/qTygjUXxRKhqmWp/g?=
 =?us-ascii?Q?9WwIpeC22wXi1ePtgOFClNUWVJpCCkjESvNdYA+5jWCC39r2CQ0QN+Axloh6?=
 =?us-ascii?Q?J5A3gPgnrEpH2VefUGUYubDakk/7UhpSdNRfAmuwkzIgoViZiHw8GEtAf+1g?=
 =?us-ascii?Q?oMnEMTwghDuIL3kHrfDOhChxLxBDso52B+8Gm+b3btv0Ms1XC6R6RCeloAs9?=
 =?us-ascii?Q?MDU8a4Wsmxg/M6BzATfmrDEEmYFddacYpzYAVf5onW8OShSh3m0mX4iOhxpf?=
 =?us-ascii?Q?jgweK6VyQqqQ+GFRrsGd+TmOmgKSklqvVrHnCOE2cRJAqaRr2azDXcfVXCN8?=
 =?us-ascii?Q?mvBhPt9h8IyNw4K21C+D3P+6f6pQvVe36BBDdPjab+XUyLONNcPG+WCuCPAX?=
 =?us-ascii?Q?6wq1+rUt6pCGuc5JLPib9T882bGtj3ulxq64+hAKF9DJKssV93WZBIA6V6Lo?=
 =?us-ascii?Q?gWFcJNZyIPSEbWwP0DbgkNVl6Pn1m4rLa1L/RZFOALQ1yy9Fzgto3rjWf+BY?=
 =?us-ascii?Q?mUpgv1lteGAU9uks+GQDBr8M1o/9PlS9Wn8APBhfUOTblvrNL962CpYH3BYV?=
 =?us-ascii?Q?FwrFbn+EVfaeMmD9bTtmB/b0lPDYAKzoVulaWmpK9EaJDRuPCnNueMt6s/Yw?=
 =?us-ascii?Q?DLp5nQOvAjKU82Qdxuw4mvCWs0zs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1P15301MB0295.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f2c119-3b3c-4b04-4827-08da097cb332
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 07:47:20.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/rNt10jXhh3fsDLKNmt6FA7hQroAr8kG9s41NLXHJYJftInamh1lc0WQKqrLb2Au9rYzPOd9A263vy/EZ6ruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0109
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: 18 March 2022 23:19
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> Wei Hu <weh@microsoft.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Wilczynski <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org; Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Subject: [EXTERNAL] [PATCH 1/2] PCI: hv: Use IDR to generate transaction =
IDs
> for VMBus hardening
>=20
> Currently, pointers to guest memory are passed to Hyper-V as transaction
> IDs in hv_pci.  In the face of errors or malicious behavior in Hyper-V,
> hv_pci should not expose or trust the transaction IDs returned by
> Hyper-V to be valid guest memory addresses.  Instead, use small integers
> generated by IDR as request (transaction) IDs.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 190 ++++++++++++++++++++--------
>  1 file changed, 135 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index ae0bc2fee4ca8..fbc62aab08fdc 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -495,6 +495,9 @@ struct hv_pcibus_device {
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
>=20
> +	spinlock_t idr_lock; /* Serialize accesses to the IDR */
> +	struct idr idr; /* Map guest memory addresses */
> +
>  	struct list_head children;
>  	struct list_head dr_list;
>=20
> @@ -1208,6 +1211,27 @@ static void hv_pci_read_config_compl(void
> *context, struct pci_response *resp,
>  	complete(&comp->comp_pkt.host_event);
>  }
>=20
> +static inline int alloc_request_id(struct hv_pcibus_device *hbus,
> +				   void *ptr, gfp_t gfp)
> +{
> +	unsigned long flags;
> +	int req_id;
> +
> +	spin_lock_irqsave(&hbus->idr_lock, flags);
> +	req_id =3D idr_alloc(&hbus->idr, ptr, 1, 0, gfp);

[Saurabh Singh Sengar] Many a place we are using alloc_request_id with GFP_=
KERNEL, which results this allocation inside of spin lock with GFP_KERNEL.
Is this a good opportunity to use idr_preload ?

> +	spin_unlock_irqrestore(&hbus->idr_lock, flags);
> +	return req_id;
> +}
> +
> +static inline void remove_request_id(struct hv_pcibus_device *hbus, int
> req_id)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hbus->idr_lock, flags);
> +	idr_remove(&hbus->idr, req_id);
> +	spin_unlock_irqrestore(&hbus->idr_lock, flags);
> +}
> +
>  /**
>   * hv_read_config_block() - Sends a read config block request to
>   * the back-end driver running in the Hyper-V parent partition.
> @@ -1232,7 +1256,7 @@ static int hv_read_config_block(struct pci_dev
> *pdev, void *buf,
>  	} pkt;
>  	struct hv_read_config_compl comp_pkt;
>  	struct pci_read_block *read_blk;
> -	int ret;
> +	int req_id, ret;
>=20
>  	if (len =3D=3D 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
> @@ -1250,16 +1274,19 @@ static int hv_read_config_block(struct pci_dev
> *pdev, void *buf,
>  	read_blk->block_id =3D block_id;
>  	read_blk->bytes_requested =3D len;
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.pkt, GFP_KERNEL);
> +	if (req_id < 0)
> +		return req_id;
> +
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, read_blk,
> -			       sizeof(*read_blk), (unsigned long)&pkt.pkt,
> -			       VM_PKT_DATA_INBAND,
> +			       sizeof(*read_blk), req_id,
> VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	ret =3D wait_for_response(hbus->hdev,
> &comp_pkt.comp_pkt.host_event);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	if (comp_pkt.comp_pkt.completion_status !=3D 0 ||
>  	    comp_pkt.bytes_returned =3D=3D 0) {
> @@ -1267,11 +1294,14 @@ static int hv_read_config_block(struct pci_dev
> *pdev, void *buf,
>  			"Read Config Block failed: 0x%x,
> bytes_returned=3D%d\n",
>  			comp_pkt.comp_pkt.completion_status,
>  			comp_pkt.bytes_returned);
> -		return -EIO;
> +		ret =3D -EIO;
> +		goto exit;
>  	}
>=20
>  	*bytes_returned =3D comp_pkt.bytes_returned;
> -	return 0;
> +exit:
> +	remove_request_id(hbus, req_id);
> +	return ret;
>  }
>=20
>  /**
> @@ -1313,8 +1343,8 @@ static int hv_write_config_block(struct pci_dev
> *pdev, void *buf,
>  	} pkt;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_write_block *write_blk;
> +	int req_id, ret;
>  	u32 pkt_size;
> -	int ret;
>=20
>  	if (len =3D=3D 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
> @@ -1340,24 +1370,30 @@ static int hv_write_config_block(struct pci_dev
> *pdev, void *buf,
>  	 */
>  	pkt_size +=3D sizeof(pkt.reserved);
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.pkt, GFP_KERNEL);
> +	if (req_id < 0)
> +		return req_id;
> +
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, write_blk, pkt_size,
> -			       (unsigned long)&pkt.pkt,
> VM_PKT_DATA_INBAND,
> +			       req_id, VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	ret =3D wait_for_response(hbus->hdev, &comp_pkt.host_event);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	if (comp_pkt.completion_status !=3D 0) {
>  		dev_err(&hbus->hdev->device,
>  			"Write Config Block failed: 0x%x\n",
>  			comp_pkt.completion_status);
> -		return -EIO;
> +		ret =3D -EIO;
>  	}
>=20
> -	return 0;
> +exit:
> +	remove_request_id(hbus, req_id);
> +	return ret;
>  }
>=20
>  /**
> @@ -1407,7 +1443,7 @@ static void hv_int_desc_free(struct hv_pci_dev
> *hpdev,
>  	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	int_pkt->int_desc =3D *int_desc;
>  	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt,
> sizeof(*int_pkt),
> -			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND,
> 0);
> +			 0, VM_PKT_DATA_INBAND, 0);
>  	kfree(int_desc);
>  }
>=20
> @@ -1688,9 +1724,8 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> -
> +	int req_id, ret;
>  	u32 size;
> -	int ret;
>=20
>  	pdev =3D msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
>  	dest =3D irq_data_get_effective_affinity_mask(data);
> @@ -1750,15 +1785,18 @@ static void hv_compose_msi_msg(struct
> irq_data *data, struct msi_msg *msg)
>  		goto free_int_desc;
>  	}
>=20
> +	req_id =3D alloc_request_id(hbus, &ctxt.pci_pkt, GFP_ATOMIC);
> +	if (req_id < 0)
> +		goto free_int_desc;
> +
>  	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel,
> &ctxt.int_pkts,
> -			       size, (unsigned long)&ctxt.pci_pkt,
> -			       VM_PKT_DATA_INBAND,
> +			       size, req_id, VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret) {
>  		dev_err(&hbus->hdev->device,
>  			"Sending request for interrupt failed: 0x%x",
>  			comp.comp_pkt.completion_status);
> -		goto free_int_desc;
> +		goto remove_id;
>  	}
>=20
>  	/*
> @@ -1811,7 +1849,7 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
>  		dev_err(&hbus->hdev->device,
>  			"Request for interrupt failed: 0x%x",
>  			comp.comp_pkt.completion_status);
> -		goto free_int_desc;
> +		goto remove_id;
>  	}
>=20
>  	/*
> @@ -1827,11 +1865,14 @@ static void hv_compose_msi_msg(struct
> irq_data *data, struct msi_msg *msg)
>  	msg->address_lo =3D comp.int_desc.address & 0xffffffff;
>  	msg->data =3D comp.int_desc.data;
>=20
> +	remove_request_id(hbus, req_id);
>  	put_pcichild(hpdev);
>  	return;
>=20
>  enable_tasklet:
>  	tasklet_enable(&channel->callback_event);
> +remove_id:
> +	remove_request_id(hbus, req_id);
>  free_int_desc:
>  	kfree(int_desc);
>  drop_reference:
> @@ -2258,7 +2299,7 @@ static struct hv_pci_dev
> *new_pcichild_device(struct hv_pcibus_device *hbus,
>  		u8 buffer[sizeof(struct pci_child_message)];
>  	} pkt;
>  	unsigned long flags;
> -	int ret;
> +	int req_id, ret;
>=20
>  	hpdev =3D kzalloc(sizeof(*hpdev), GFP_KERNEL);
>  	if (!hpdev)
> @@ -2275,16 +2316,19 @@ static struct hv_pci_dev
> *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	res_req->message_type.type =3D
> PCI_QUERY_RESOURCE_REQUIREMENTS;
>  	res_req->wslot.slot =3D desc->win_slot.slot;
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.init_packet, GFP_KERNEL);
> +	if (req_id < 0)
> +		goto error;
> +
>  	ret =3D vmbus_sendpacket(hbus->hdev->channel, res_req,
> -			       sizeof(struct pci_child_message),
> -			       (unsigned long)&pkt.init_packet,
> +			       sizeof(struct pci_child_message), req_id,
>  			       VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		goto error;
> +		goto remove_id;
>=20
>  	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
> -		goto error;
> +		goto remove_id;
>=20
>  	hpdev->desc =3D *desc;
>  	refcount_set(&hpdev->refs, 1);
> @@ -2293,8 +2337,11 @@ static struct hv_pci_dev
> *new_pcichild_device(struct hv_pcibus_device *hbus,
>=20
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> +	remove_request_id(hbus, req_id);
>  	return hpdev;
>=20
> +remove_id:
> +	remove_request_id(hbus, req_id);
>  error:
>  	kfree(hpdev);
>  	return NULL;
> @@ -2648,8 +2695,7 @@ static void hv_eject_device_work(struct
> work_struct *work)
>  	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
> -	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
> -			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
> +	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt, sizeof(*ejct_pkt),
> 0,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
>  	/* For the get_pcichild() in hv_pci_eject_device() */
> @@ -2709,6 +2755,7 @@ static void hv_pci_onchannelcallback(void
> *context)
>  	struct pci_dev_inval_block *inval;
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> +	unsigned long flags;
>=20
>  	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
>  	if (!buffer)
> @@ -2743,11 +2790,19 @@ static void hv_pci_onchannelcallback(void
> *context)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>=20
> -			/*
> -			 * The host is trusted, and thus it's safe to interpret
> -			 * this transaction ID as a pointer.
> -			 */
> -			comp_packet =3D (struct pci_packet *)req_id;
> +			if (req_id > INT_MAX) {
> +				dev_err_ratelimited(&hbus->hdev->device,
> +						    "Request ID >
> INT_MAX\n");
> +				break;
> +			}
> +			spin_lock_irqsave(&hbus->idr_lock, flags);
> +			comp_packet =3D (struct pci_packet *)idr_find(&hbus-
> >idr, req_id);
> +			spin_unlock_irqrestore(&hbus->idr_lock, flags);
> +			if (!comp_packet) {
> +				dev_warn_ratelimited(&hbus->hdev->device,
> +						     "Request ID not found\n");
> +				break;
> +			}
>  			response =3D (struct pci_response *)buffer;
>  			comp_packet->completion_func(comp_packet-
> >compl_ctxt,
>  						     response,
> @@ -2858,8 +2913,7 @@ static int hv_pci_protocol_negotiation(struct
> hv_device *hdev,
>  	struct pci_version_request *version_req;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	int ret;
> -	int i;
> +	int req_id, ret, i;
>=20
>  	/*
>  	 * Initiate the handshake with the host and negotiate
> @@ -2877,12 +2931,18 @@ static int hv_pci_protocol_negotiation(struct
> hv_device *hdev,
>  	version_req =3D (struct pci_version_request *)&pkt->message;
>  	version_req->message_type.type =3D
> PCI_QUERY_PROTOCOL_VERSION;
>=20
> +	req_id =3D alloc_request_id(hbus, pkt, GFP_KERNEL);
> +	if (req_id < 0) {
> +		kfree(pkt);
> +		return req_id;
> +	}
> +
>  	for (i =3D 0; i < num_version; i++) {
>  		version_req->protocol_version =3D version[i];
>  		ret =3D vmbus_sendpacket(hdev->channel, version_req,
> -				sizeof(struct pci_version_request),
> -				(unsigned long)pkt, VM_PKT_DATA_INBAND,
> -
> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +				       sizeof(struct pci_version_request),
> +				       req_id, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (!ret)
>  			ret =3D wait_for_response(hdev,
> &comp_pkt.host_event);
>=20
> @@ -2917,6 +2977,7 @@ static int hv_pci_protocol_negotiation(struct
> hv_device *hdev,
>  	ret =3D -EPROTO;
>=20
>  exit:
> +	remove_request_id(hbus, req_id);
>  	kfree(pkt);
>  	return ret;
>  }
> @@ -3079,7 +3140,7 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	struct pci_bus_d0_entry *d0_entry;
>  	struct hv_pci_compl comp_pkt;
>  	struct pci_packet *pkt;
> -	int ret;
> +	int req_id, ret;
>=20
>  	/*
>  	 * Tell the host that the bus is ready to use, and moved into the
> @@ -3098,8 +3159,14 @@ static int hv_pci_enter_d0(struct hv_device
> *hdev)
>  	d0_entry->message_type.type =3D PCI_BUS_D0ENTRY;
>  	d0_entry->mmio_base =3D hbus->mem_config->start;
>=20
> +	req_id =3D alloc_request_id(hbus, pkt, GFP_KERNEL);
> +	if (req_id < 0) {
> +		kfree(pkt);
> +		return req_id;
> +	}
> +
>  	ret =3D vmbus_sendpacket(hdev->channel, d0_entry,
> sizeof(*d0_entry),
> -			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
> +			       req_id, VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (!ret)
>  		ret =3D wait_for_response(hdev, &comp_pkt.host_event);
> @@ -3112,12 +3179,10 @@ static int hv_pci_enter_d0(struct hv_device
> *hdev)
>  			"PCI Pass-through VSP failed D0 Entry with status
> %x\n",
>  			comp_pkt.completion_status);
>  		ret =3D -EPROTO;
> -		goto exit;
>  	}
>=20
> -	ret =3D 0;
> -
>  exit:
> +	remove_request_id(hbus, req_id);
>  	kfree(pkt);
>  	return ret;
>  }
> @@ -3175,11 +3240,10 @@ static int hv_send_resources_allocated(struct
> hv_device *hdev)
>  	struct pci_resources_assigned *res_assigned;
>  	struct pci_resources_assigned2 *res_assigned2;
>  	struct hv_pci_compl comp_pkt;
> +	int wslot, req_id, ret =3D 0;
>  	struct hv_pci_dev *hpdev;
>  	struct pci_packet *pkt;
>  	size_t size_res;
> -	int wslot;
> -	int ret;
>=20
>  	size_res =3D (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
>  			? sizeof(*res_assigned) : sizeof(*res_assigned2);
> @@ -3188,7 +3252,11 @@ static int hv_send_resources_allocated(struct
> hv_device *hdev)
>  	if (!pkt)
>  		return -ENOMEM;
>=20
> -	ret =3D 0;
> +	req_id =3D alloc_request_id(hbus, pkt, GFP_KERNEL);
> +	if (req_id < 0) {
> +		kfree(pkt);
> +		return req_id;
> +	}
>=20
>  	for (wslot =3D 0; wslot < 256; wslot++) {
>  		hpdev =3D get_pcichild_wslot(hbus, wslot);
> @@ -3215,10 +3283,9 @@ static int hv_send_resources_allocated(struct
> hv_device *hdev)
>  		}
>  		put_pcichild(hpdev);
>=20
> -		ret =3D vmbus_sendpacket(hdev->channel, &pkt->message,
> -				size_res, (unsigned long)pkt,
> -				VM_PKT_DATA_INBAND,
> -
> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +		ret =3D vmbus_sendpacket(hdev->channel, &pkt->message,
> size_res,
> +				       req_id, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  		if (!ret)
>  			ret =3D wait_for_response(hdev,
> &comp_pkt.host_event);
>  		if (ret)
> @@ -3235,6 +3302,7 @@ static int hv_send_resources_allocated(struct
> hv_device *hdev)
>  		hbus->wslot_res_allocated =3D wslot;
>  	}
>=20
> +	remove_request_id(hbus, req_id);
>  	kfree(pkt);
>  	return ret;
>  }
> @@ -3412,6 +3480,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> +	spin_lock_init(&hbus->idr_lock);
>  	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
>  					   hbus->bridge->domain_nr);
>  	if (!hbus->wq) {
> @@ -3419,6 +3488,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  		goto free_dom;
>  	}
>=20
> +	idr_init(&hbus->idr);
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL,
> 0,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -3537,6 +3607,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hv_free_config_window(hbus);
>  close:
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
>  free_dom:
> @@ -3556,7 +3627,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev,
> bool keep_devs)
>  	struct hv_pci_compl comp_pkt;
>  	struct hv_pci_dev *hpdev, *tmp;
>  	unsigned long flags;
> -	int ret;
> +	int req_id, ret;
>=20
>  	/*
>  	 * After the host sends the RESCIND_CHANNEL message, it doesn't
> @@ -3599,18 +3670,23 @@ static int hv_pci_bus_exit(struct hv_device
> *hdev, bool keep_devs)
>  	pkt.teardown_packet.compl_ctxt =3D &comp_pkt;
>  	pkt.teardown_packet.message[0].type =3D PCI_BUS_D0EXIT;
>=20
> +	req_id =3D alloc_request_id(hbus, &pkt.teardown_packet,
> GFP_KERNEL);
> +	if (req_id < 0)
> +		return req_id;
> +
>  	ret =3D vmbus_sendpacket(hdev->channel,
> &pkt.teardown_packet.message,
> -			       sizeof(struct pci_message),
> -			       (unsigned long)&pkt.teardown_packet,
> +			       sizeof(struct pci_message), req_id,
>  			       VM_PKT_DATA_INBAND,
>=20
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
> -		return ret;
> +		goto exit;
>=20
>  	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) =3D=3D
> 0)
> -		return -ETIMEDOUT;
> +		ret =3D -ETIMEDOUT;
>=20
> -	return 0;
> +exit:
> +	remove_request_id(hbus, req_id);
> +	return ret;
>  }
>=20
>  /**
> @@ -3648,6 +3724,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	ret =3D hv_pci_bus_exit(hdev, false);
>=20
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>=20
>  	iounmap(hbus->cfg_addr);
>  	hv_free_config_window(hbus);
> @@ -3704,6 +3781,7 @@ static int hv_pci_suspend(struct hv_device *hdev)
>  		return ret;
>=20
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>=20
>  	return 0;
>  }
> @@ -3749,6 +3827,7 @@ static int hv_pci_resume(struct hv_device *hdev)
>=20
>  	hbus->state =3D hv_pcibus_init;
>=20
> +	idr_init(&hbus->idr);
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL,
> 0,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -3780,6 +3859,7 @@ static int hv_pci_resume(struct hv_device *hdev)
>  	return 0;
>  out:
>  	vmbus_close(hdev->channel);
> +	idr_destroy(&hbus->idr);
>  	return ret;
>  }
>=20
> --
> 2.25.1

