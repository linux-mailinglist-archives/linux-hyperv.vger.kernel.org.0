Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD97890CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Aug 2023 23:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjHYVyZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Aug 2023 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHYVxv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Aug 2023 17:53:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA426AF;
        Fri, 25 Aug 2023 14:53:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEJG8011032;
        Fri, 25 Aug 2023 21:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Nwek5df8OG5D5Iliip4VWRlyomrKCFEqYQkXldVmbHI=;
 b=Mpp2wYe5+AUm9HQYqde0DUSsGTZcZ86Thg1frWhQbK3iFkrMgRVrd/guD2HThtD1SW/A
 OmqQyfbYOdEfkSNnMGdyV7vM5QYseZvSQm54FuDODC8GGyvYxcDKgakYI2OaVaUCqJRk
 vKHiH5/myl62CeDgH6s/zPDIEBGiSkzNwA6TWz8LcBMx9wxOEAINZ2z1+CShiRs2PSWD
 21ncY9gISuPMB2HLyIt5wN3p9PaF2ypifW9Okaabnj8u/WOhhtVvmtKfaLatpsLvG5rv
 rnAPViaOtHSfG3KmyFJaGkimGdSMGlVZ5B/giweQP8MzFWX0Pd3sdifIB+k9X5Bsc7Xa KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv7ckj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:53:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PJoHje036185;
        Fri, 25 Aug 2023 21:53:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxvwkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Beh4c3iZIrSCz+q5IlaICJ76BKvo1Agiaq7Y7GeP9rVlzi/lNoikODIFFVneckSl5AqQVD5eN8AvmZeiFlGVJiVrMZvqLUa/0n1fuv/3G7RL8u2pbqYt9eZESS1s0uPIn2VDbGYP3J8Mj/M3yksXxNSuDVv3bq6stmJx48rvMFZi7dHslccyOIniUuXkp6VA6ijNldxFBLXgoudGjC7W5MJmXQsA3Y0g+UVqPKlKvXKPrKj9zKu8sfB2c+SiQgd56+wwCKOXdK6ZKbVlN3tyTnCp1DH3LDz6BH7tSUUbQ0KU/bmamwEwVCzpCtkfnU2GfQcvvbF06TpRf+3Kd449Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nwek5df8OG5D5Iliip4VWRlyomrKCFEqYQkXldVmbHI=;
 b=IxOPzr9CrM8ALOOiI/8YKvz/uM0XAEK8VtdZkanCZ2jwO12saTdIF//3ESGTM7v/nPPfaTFc0yOWXoNLVm02GF/BT7uSIYuVNM3BqaYbI0lSplfFeGBL8gackKwQpmuF1MzUA5GAvnwAFh5xNcpE33eLh3mSCab4XLdTaj2AdUZR3aiwcSWD32ghU3oia2WpJ5xkGpCSxd2prrlOWfDx7xU/CgdsDQZyOJTClB6wm1pK3iA2F3lBQfBOGnceOjFZUJSVxf9pwXDupdaK6nQxCeSn7A+ZcSGM5987gsvBr/IPE5caqv7Ifs3swglV9Ad8znmvY7hX8aLMa+102yYveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwek5df8OG5D5Iliip4VWRlyomrKCFEqYQkXldVmbHI=;
 b=P4Yye7Th9lhyaxQ29Ux4wWgRRojDpZfdkugSTSS6g+rOxH4s5smnU376m3GqPyUdJoj4rl6q1vNtMBwbPQfyFSaNiEgRQmrQCFfKmtkavwxyp4CfLsw1002W1DgIqNYXOavXxj3XgjPzH9uRWuGg4Fn6jFORyI7DIg6D7ZArujI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4518.namprd10.prod.outlook.com (2603:10b6:510:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 21:53:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.034; Fri, 25 Aug 2023
 21:53:29 +0000
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Handle additional SRB status values
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkeuzt6l.fsf@ca-mkp.ca.oracle.com>
References: <1692984084-95105-1-git-send-email-mikelley@microsoft.com>
Date:   Fri, 25 Aug 2023 17:53:26 -0400
In-Reply-To: <1692984084-95105-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Fri, 25 Aug 2023 10:21:24 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9dc032-9774-495c-3ee8-08dba5b5b78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdnLQupkOVY+CPQyQQu5PM85YE5Y7iYjEsasw+SPnCuxgsRXMYoU1GbDB8nol81Bwl2CSVNrIR8ZGo7ml7F+zZ8EEfAJUBIBMbgBm8m8XsaAMnX/jaNBubAjQrFiryM7BFX2C1tfe+lfnU3PoiEr6bxVS70yjuPTO6M7whX4wa8wudOmmn+o6/QLWf19VpB0BXiICpEE5HFPJsqva8sCqCyyQAHY8lppK/1h0TsD4gwtOx/6c84Eh9r9+IGDBpgYvImCZeLK7/JJ7dAwxYJQzgF+jSFXl9H/8h691FokSCuKjToO4mNLqHLpeHU2Ga4GdDwzjGjOuDLV7tLVlBlZ2r9gUSRMRC6WRagiqQQpGdTbaISRpWzJts2m+PXOtoFMgnS8U76qPqyW0jT74SOKxoZWNMK960kXdYvevZi1R4+jwV5Rbx0PrQrodyT5F7S2jJxg4ezP7hiz2mZe4qrqc0Qr/t6sffzGzxgD/P4LtMDYKvpp5JIc6c7CR+gzObG4D/FGQJmNJdM52GvLIM7iaJqlMcxY2OPmZo62mgoFK1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(1800799009)(186009)(451199024)(8936002)(8676002)(83380400001)(5660300002)(4744005)(4326008)(26005)(6666004)(38100700002)(6916009)(66556008)(66946007)(66476007)(316002)(478600001)(966005)(41300700001)(2906002)(36916002)(6506007)(86362001)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAarsCBDXnNb3qzDvY5tT/ahPwIRHaI6ytIVSWudjz1YtQdvQ2Q7zLJFHSDw?=
 =?us-ascii?Q?H9cfdoec7yhD29CyysJBC4YR+hO4Cuw2V7Z0G+XunK8Qdq+5C7vi9J1+ywRU?=
 =?us-ascii?Q?UVGeGyCNGHtbePcLnfNgOP9Jbk6itdOZS2/ozCqOTqA3NhFBd3sA88QV0IOi?=
 =?us-ascii?Q?GenHgyVlOTGc9gEnAm7kgbvEca5dzuHtQ1Qnex46RzYu6J0PthtNutlQnMR2?=
 =?us-ascii?Q?ChPx3PrfOeIPeSd+EwNEFqcFB63P/B/0TlQo51f3PmzcWOu7MbFscSEGK/YW?=
 =?us-ascii?Q?o4qFWyYniTM5j5l5gTaWAoyyyF04DJctg8lo1GpenjQsSwtiAHh/2b9WwdYd?=
 =?us-ascii?Q?FA++a3Ix0nF0lQGoezWF/r0O1H4GgT94lbkeu8fubOf1WmX444LeDqUYXDqo?=
 =?us-ascii?Q?2MSCDb8Id5i/4MzCAyCvTfoaF583HuHDTLOERzHRNJvOl70ZpFlWx0V7ZmMH?=
 =?us-ascii?Q?BZGkpriwwghneyuszde/jEii0KnxGS0Nw7zQfrrqMmEzHHkvjGX6RleiwrLu?=
 =?us-ascii?Q?AT8RAh2uv0A8xUb41NzVy8F2TkK23YkAJg6nEDMtkKO0WYkxSf3Gkhhhh53P?=
 =?us-ascii?Q?Jygb7WqERibai7DokARGpybbfY4r4bBgRFEKz8AM7ZTOWm/Z8wgO3dLtJ/Er?=
 =?us-ascii?Q?BXZgw/OIOJn3ovfHfWA10mGjeFOs3SHuZAZXbAThYh+XJSL1qs0AuJpeOvBS?=
 =?us-ascii?Q?hBTntuK1npjBDBj6iBEeVmoY8P3X8YscPTNFj0gHs2NuAw++2tTFxayta9Bj?=
 =?us-ascii?Q?W6LSQxQzxgVc6OvwCrDoYuiPZ11f5vtMoDzZZFCJyS57EQNJmLDyXOjYrUd+?=
 =?us-ascii?Q?BpSRzX3Hs2inXL++1i4cC4ZYRqW+3l3Jwki+D7B/Q1QsWW5V2v3fI32vx6mI?=
 =?us-ascii?Q?CoyQc0HhT14SsAOW2dKPa0eTibl/vimiy3RUuF4sWL050PYoirWCMh9ZHOeN?=
 =?us-ascii?Q?z4TjzXsOOvAG1BXEQlxceTtGqCMua1SWL5+2quUzRb8Q2ZpoJq+ricI/YVgF?=
 =?us-ascii?Q?bIp2LgJzpahBuoFyZd36EJwESnu/5uQyGVigDG5bqdM2e4vR22j+uCF8VGdW?=
 =?us-ascii?Q?le3uZmwG5U6TTSRteJwruxt62Nuasp5HNsg3HMN7dztGbzcXkq9dlK2kDMb3?=
 =?us-ascii?Q?Pmqy9AIOpClaI5m7/f06zkOxff2RZK3Ru2VAd4+D7Bx1ouN60jA7Dnr+jnG7?=
 =?us-ascii?Q?1WmYrmKBimwifZg0czX0R/Nk4WCjNneAXibBInCyBfqemYBjKjMqSbqGhsrN?=
 =?us-ascii?Q?V0f2PjRaGO2P0FhIZQEw8+a5W5Nr8cTx7GKFI/Gls2F78nV0DNJdG6IVsqZy?=
 =?us-ascii?Q?/rIF7JhwELLgrpuVd0AiWNeurGv6YV6VydKdwp6zv+dS58U9QuNTOxBDSqx+?=
 =?us-ascii?Q?pwHq1rsP2W8kc1Hwp7G9+nSYRnmaVnErnPgBUoSJtykez97GFcx0n3sZgJfC?=
 =?us-ascii?Q?Z2pj4YdlM9a3Jy7HMiD/xhvDV0f41B7sFeme7r9RWcTzwtFa7Xqmm3QIa+Co?=
 =?us-ascii?Q?kN2TqOj22vjr1f++eRWP6LqHREXruBCK5lVsnEG5pBOSqEInEL23UB/XubFI?=
 =?us-ascii?Q?OK73dJKaAo96NW+dAdOBE62qjaxIa6L/TPAdN1TYrapdv1YxOejyehHLjUzO?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fugGbENQKYQmTfMC3gLOWpT5j3r3DE29HhjMrW+cIEuVzOwLiFdWb2n08vLAVoVGdPTJ0U2RJszClTJ46VNMPajwgSbH0GruaElaoYziPVL6MQ+ABKOqBmDMOgS7q+rw0UV6GnSmJ66mp2POOHgzgwVputYMdTxZx8HEBY5VfUX5/vn57vV/o9gvu1vNiEwwToG7NCBi1aIguS2pPjNWTzzzCI+O2lyCvYiDc2SZw5O9AH2KwvT5WYngyovslDuEESCPkd7lRI2t32Nzjp/X6JIbnGippj8JiKoSGVhUm4LYTeL60s9vack4INmeTQTbnRCJYbe/gQ3JFAlcgKuXKKdA2ehtxBhZeiJ9GGg6PNLcrJQoeAHwTMHuOtp392C9Edx6N0yFZQ7fDdpcRmnFhvDo88ovWiVkyAFQjGbjBTGOzNNex0BbR6WfML0rLvCcwttUBrNmAA3C1faIrfKdUJEJrRzmYvi/uzwAGsa6rDXGE3vBeOPsFqyTGeAmQpnrQYIziw9Pq5qyzPFLPweRkqCe8Ido4qdF5MYCKVUtV0Rz8q2P3v88dgaO/yo5F5GCs40Al5SVnmgf/RyxFVG6BhDNJL5zYfdD2XcYUokE/R0sBatXLbZOgI+B8vfyOoyLCYIHt86DAZ6SBu0a3X9C3oJ7Urb9ZtBkE1hSzFAmZ4kiamtege0lGW0whBE19991yluHPpePQZTGYSRBgMLVRn7B9eSSy8lrTfsj6Zs8OaeQO89SUbbjWqW3AnsLqAVN9U8bU4c7BjQp3jgmcGl4sVX7coDPLYVQ5EOmA0UT14m2mYc07WEoORezqcqZ9i0YdfIehsdQdJeG5iiVEOayG9XtcPg+IXLerhtppdsNbKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9dc032-9774-495c-3ee8-08dba5b5b78f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 21:53:29.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJzzEIeY0jeImZG8I0sObZBdvcED25LRdSLL4oXRxAQZoE7lYzwmjIZvl346+f8VrdtrLpKQKajoxoM7xOcVZmL/RXIGbeQLSSUo+kZzykA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=737 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250196
X-Proofpoint-GUID: pAkxmGUcjDQFSmxQle1lPN0ra1GP4T87
X-Proofpoint-ORIG-GUID: pAkxmGUcjDQFSmxQle1lPN0ra1GP4T87
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Michael,

> Testing of virtual fibre channel devices under Hyper-V has shown
> additional SRB status values being returned for various error cases.
> Because these SRB status values are not recognized by storvsc, the I/O
> operations are not flagged as an error. Request are treated as if they
> completed normally but with zero data transferred, which can cause a
> flood of retries.
>
> Add definitions for these SRB status values and handle them like other
> error statuses from the Hyper-V host.

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: storvsc: Handle additional SRB status values
      https://git.kernel.org/mkp/scsi/c/812fe6420a6e

-- 
Martin K. Petersen	Oracle Linux Engineering
