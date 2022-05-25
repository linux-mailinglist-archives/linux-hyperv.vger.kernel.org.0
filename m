Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDB533E45
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 May 2022 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiEYNwJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 May 2022 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEYNwH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 May 2022 09:52:07 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC887221;
        Wed, 25 May 2022 06:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI5hiA3n1YZ5jm4UfqHSC+F/A3Uo2A3YNdS7etQrU8ddUJAAxQ7a067duvp2zpOaIf9Zh3kFZ0QOnqbTI/x4GZD+hYerLuT42dLRaaslMZ3jH6RAZgQCgRg02AAGxmBDTrgESRI8iiG/LtckvaMFr7/3LkhF/19Jp8BV0J4IVQ+k/gT9FSjwVKge3e2oaGBw3xQ6qzizJLVY9S0AMvyhE1VuEHSnM2jxINoL3wvO1DKmvb/ewXpnoMD+/vj3cfz3MdhMi5MTH/iIT00bTc73FKm/V0tpY4eaUAT3Q0EBsvDUxD1IgSprXIMA+nNBsTCuPh/5wuSKe/f/YiofSwUsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1vEreOQuFJX1BPYnwab/jLGY74ke3N381XsZq2sPUM=;
 b=lE3CVGrrRtaZF11SXE5LbvqO9LFoX2SQ0Gm1zQIgU9C7ikNtracx4QCXZZlIKBkY26saajmj7fchIx/WzYnov//z6b5iDWnJsmr6Jv8JIQYMmwAa4f9Yd58HbmxRtEcWcxufvi2rfWSLpekjVxh8RIsL6dtkJ+lbse/7NQZejtcJ4Rtl8yRnaDf0uAiGj13SmH+mQyRNB5ZS8+xcIGjWoMl29OxiPTjMyYcfKQaeHJZbU3bMrHc44CUK205CThD+UuP1nWkie23GQStwNhdTtOwHsg9ez0gIu3ofL+XIzRTj0kB+CWNoawlqcs6P2HAVMbyhbsDYcbzjv38b7Ix7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1vEreOQuFJX1BPYnwab/jLGY74ke3N381XsZq2sPUM=;
 b=U8+qFUirbKoQqtbVwsdvoeUONvbCCRTM23kB7O+/0c0NFpoSQ/+QFBN/unUfQsCSOaWNU5Sz9OBRsfvHO2p7qWjB1iYfHC3LHsfvtEoxM0yR8iGLai/DRLTvcbeWf4L64r1EPvQBuQ/PfB04IK63qUP37VPNJRtKOAhbmZrBV8Y=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by CY5PR21MB3420.namprd21.prod.outlook.com (2603:10b6:930:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.3; Wed, 25 May
 2022 13:52:02 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::3506:defe:c88a:8580%9]) with mapi id 15.20.5314.005; Wed, 25 May 2022
 13:52:01 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] scsi: storvsc: Removing Pre Win8 related logic
Thread-Topic: [PATCH v4] scsi: storvsc: Removing Pre Win8 related logic
Thread-Index: AQHYcCph6JjUB5TEYECv1qJg2uIBQK0vnDwQ
Date:   Wed, 25 May 2022 13:52:01 +0000
Message-ID: <PH0PR21MB302574301005664B719B5196D7D69@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1653478022-26621-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653478022-26621-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aac07181-e8c7-42ad-b51b-40a37d68c60d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-25T13:49:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe498dfd-4c44-470b-d57d-08da3e55bea8
x-ms-traffictypediagnostic: CY5PR21MB3420:EE_
x-microsoft-antispam-prvs: <CY5PR21MB3420AF75987775EC07EF33F6D7D69@CY5PR21MB3420.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ea/9/58cAXWbxoZhr7CbDU2oVsjgGz5lNb/7dovqY5KnhcrJ4yhvt3YzPFjkKCSH3/udyq3tcbG0XfxubV8E9ESBqyQ1PJOd+n/kEK4ufiVlPAAS7EuW5+V05HZcC/ZZGve2ShB5YgP8ZG33rM7Na17uovCmz03CHC/4iS8Rps9Nbq2Chs7qiROgvMzObkVO4DBCwUt3H/oVSjJXGqbZYJ+CYiK//oLLB6hW0bznmdSTNp6oNGnpqyTsws/UFKS5l8N4VgJHi23ENPkzu4ycDFP7lQxejTF+P7rEeIE7cSlOnbgNjHZ3vEb3UXzkomsP2pQtztuG8Ue9bNA5Fyk0fIZS+Hu6o+RyfOAcXKoWiLQTiowGdNHa+ETXreW8wOfCSt5SkiKDxp7IRo9vXZ0zrYU+zIaPJQWFOPJEP+AnJ26xDw4FHdviwK3JM/dJ+aa9AxKYeFhqSK6+/kbTn3fpsM1BFQ4Pn8OX0djEPJ3boPuNN7puFXAFrJTZk0vMB01t2N0ZLbMCm7tt5RJao3L/9KJMVREHqa4WeW7pGkR6gSnBzAFnSiXht0A/y07AgJqY8Hkmyg+/OmfWFk4NAcWyV920Va5RQcmZJiTP4GnVo0B4T44MvAVyNneSgjc34YtofkowFnlNASXBjsPhwXDOl9SgisudIXapXVeKfQB+fGSvWQ86HB7RH7hobSHfqLRxPe8R7UGTcXA8Z5NROWxH87ovJH5TXXOKh33BSw0/WHvrvyi0Qnqg/akuY7o3RkddLaIKgrXppEZxgWNh5aRlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(186003)(508600001)(5660300002)(316002)(26005)(9686003)(8990500004)(122000001)(2906002)(83380400001)(8936002)(82960400001)(921005)(82950400001)(52536014)(71200400001)(86362001)(7696005)(6506007)(10290500003)(8676002)(38070700005)(38100700002)(33656002)(55016003)(64756008)(66476007)(66946007)(76116006)(66446008)(66556008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OTAjVt292Inv8Uuj1UUhkxLJryeerZ27pLyyNKbsONWX6uy8E/Vxf8vJ/mXU?=
 =?us-ascii?Q?YnOwCF9H0mz1oekeTqm5ivG4ElMc9XvVgVZu6CM9yF1q4i7jHv+UIqQlagvk?=
 =?us-ascii?Q?yKw69Ii+BuKRCgu6mB3/SaaTBx5mLn/V1myrjtadrrDHNeuG3JO3KIksfIkn?=
 =?us-ascii?Q?1sk9c676ZjOXZ3pbgs6UxXjXR+ygwNt0eu7Cjv6VTXn598+E+YXVkZbcBMHb?=
 =?us-ascii?Q?iWPpHHr3z7PnICVi2LIdT1amx5jiHiChGWC4e/9VM/WOPfoLrcY9qtH/yxn6?=
 =?us-ascii?Q?XSMjKE3dSJJ6++fLrpYiX2Hzl5oUh8Jel1/PuFI4GNFJFxeKTkQAulvrPi+Y?=
 =?us-ascii?Q?Q5VDz7aQCk9GAKnKVf6z0UVFiykjHTPvJGFD9CUpY1fnuL1vnBGJ4xfUhmmu?=
 =?us-ascii?Q?qq4DqQvaDXyT+WCs07EiEATDKDO8ZSJunTH10RDf2PLsmmdbV5ewOta3f8Rh?=
 =?us-ascii?Q?mDWkqKwvpA0hGhPHIdDu30QDbjESjSjUiW53cdI0u4HKB5tHVRfR6+9fibxM?=
 =?us-ascii?Q?Vjw5Puq9g6EibAKhF+lU4dEAXJ3cqt7msD7ohmA5zbrMqZ/fIR1QtVGz3Fv9?=
 =?us-ascii?Q?I6LvAlDdV3vQ/eRrkhDY02QHF+y6sDDgcDOdn/UxYnr/+oY+W6wmpb6Q80+w?=
 =?us-ascii?Q?0FEwbXI1svNLyQeBhruYymZousrpc+xLm+Z0ITSUUo0eTkhzKQOWSEHo1y8/?=
 =?us-ascii?Q?xR7epF3yhdlIq9+P0yEvSUWc084EJmRPcOmZFmoQvjSfAjXd0HkxI2FSeEHC?=
 =?us-ascii?Q?xrBUwqgPLqDbcppE/Tyt+QHhUIvNEfs5sHvtTF2K+6wHskjnVNFp+8YNW7o9?=
 =?us-ascii?Q?wefQzqD3aJZ8EDc5rzLvCs5sbgfPqdzNFfEHfT+VrB0Q8Sjzasq5V/bMcYSE?=
 =?us-ascii?Q?XhqDzsuaPinCkJhrgIu42LiNcWFnnfnxtWBZ84X8156/ZucGGc2p8uSQR5ds?=
 =?us-ascii?Q?wKjrNVEUQUsjvZyZOSJiSljc9o1XJUNY4u725aYK0I8zaRA6VjjZjqXqH+UW?=
 =?us-ascii?Q?DTqRFIqXZ54gTDnvZd298LV/s9Txpx0ocOGHKuzUmKWdYHXiHIqiYKW+SdS7?=
 =?us-ascii?Q?mRB7BdjMblnW4/Nx8a8PH5cGIb4FBsGiwTE7+xJHwQ3egAxDo5ms2JZEJW+Y?=
 =?us-ascii?Q?tZVcT6zLhjrpPHL/F8EgGdNveNEsWbeOHBT9W3h/HkHS1MhxkPuSOIctMnKz?=
 =?us-ascii?Q?id9TB66Jljpfq2/ZfA3rxCbltSDkm7DQd8wYstC2kdpx/U4Yvw90AoEBrowT?=
 =?us-ascii?Q?58YthsNUGByWmZ9+Z76EUAZWOTdOSCCIqcaF6KrU3KaffdhBRUcIyl/i3B/w?=
 =?us-ascii?Q?hwd71ra4nKDGAFOUQlNOXtT5M87YvJU7RiOnpmTU3Il/QMZXJsqDrdrlSqV5?=
 =?us-ascii?Q?U56fLcCN737QoJ+OFnRl5DsgLAqTb5qcWCzuk8bzfVqSMmuLlPi9NSFVHM7m?=
 =?us-ascii?Q?AjilFCs5TGgKb1iXhCeVez5gKcgzQJmumVj8pYpKZcUwwZIUY9v8cJmZXNdd?=
 =?us-ascii?Q?NSylCCL7mDY2iN+SkuzDafsVg/26LEhlOrsBPZVZ4V8zTj0c/lxlueDOLvto?=
 =?us-ascii?Q?lHMAU9AHvLpQf5titaE6tYxVJtp3OOrSF7yl4o783PnLL/KbRDFJsLoRgi1M?=
 =?us-ascii?Q?krreW0bfCqL7vafWHgWnl1CCZtdQIyXqkfYViBbVIu5pRY5oZo88t3WjeI7B?=
 =?us-ascii?Q?KDA2MQftJryLcdSBAllUND+ETTFndXxgrsOojSPhxArsp/EstKRxjNFBJkle?=
 =?us-ascii?Q?TzykiHbtFxScFVzoJ3mnPQdne75hl60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe498dfd-4c44-470b-d57d-08da3e55bea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 13:52:01.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nK5HwNPYFwNbiLHgxC7/0btbxF+SEB318sW5ovybDjAre9uNvbHWTHm1LJVif93KFhial5NlzB2N7sHi/VrhS3rT6BQkohWOY1Em60Re/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3420
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, May 25,=
 2022 4:27 AM
>=20
> The latest storvsc code has already removed the support for windows 7 and
> earlier. There is still some code logic reamining which is there to suppo=
rt

s/reamining/remaining/

> pre Windows 8 OS. This patch removes these stale logic.
> This patch majorly does three things :
>=20
> 1. Removes vmscsi_size_delta and its logic, as the vmscsi_request struct =
is
> same for all the OS post windows 8 there is no need of delta.
> 2. Simplify sense_buffer_size logic, as there is single buffer size for
> all the post windows 8 OS.
> 3. Embed the vmscsi_win8_extension structure inside the vmscsi_request,
> as there is no separate handling required for different OS.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> v4:
> * Removed sense_buffer_size variable and used STORVSC_SENSE_BUFFER_SIZE d=
irectly
> in all places
> * Removed the comment along with sense_buffer_size and placed a more simp=
ler
> comment for STORVSC_SENSE_BUFFER_SIZE
> * Added back WIN6 and WIN7 protocol version macros
>=20
>  drivers/scsi/storvsc_drv.c | 155 ++++++++++---------------------------
>  1 file changed, 39 insertions(+), 116 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
