Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2549520AC2E
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2020 08:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFZGRN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Jun 2020 02:17:13 -0400
Received: from sonic312-22.consmr.mail.bf2.yahoo.com ([74.6.128.84]:33426 "EHLO
        sonic312-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728287AbgFZGRN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jun 2020 02:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1593152232; bh=OulVYBDqCxFN0HMpT2i1Q2OUBxNivCJ6FEqc8tDI1Kg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=YH8yv/W+/iI0m5sNDTJYd8pwe5zjt6ehEP17INktrkus02OuD1Yw6nil2v4dFtZsVnNIh0InJWC6/iJtXzf0uabfMy4QKYl4VeLX5B4C+97j16LYZzwP7GxcDAvx2zbXdhKPfTRyXrEr1c4F+k23/e4u5mwEIws2KLnw5b0zPgBspX1G4yfehBEV8NQTkAUJ6o/VyQEm2wKyOgsmhhLic7AmPxhcXCwXPj9SR1XGWZVb/o9TiXovL9/cR4DtxSionSe0Jdk5XGdGJJ8kXk4A/EuPEdUlrpHBFIihW8ZpgxAb+Ku6VM4I4y9ESLq/KGaTDDfQ+5Yiafnxgd2zpEKQhQ==
X-YMail-OSG: ATWejB8VM1nDvzNUVyQpMUu5EJiYYdDrzk7.nc3_H.5JKbrvpiMAOpLnZM9sOBg
 CAf.Tme90Ome4VeKiGtZGPNfMVWBoK9HjLQbzkcGQtBpnmJCFSm7fPBsUszgAmKuj3unzwhrfVLA
 qtktE2xrEU.drxOGosljTIhilDAsJFPOywJDSey1TWRIzRHgkkleQLBGMddic5yApVhPn5x8qnMr
 cBDdsr6qPNasmQTSttXupjUDC6KrdH0Z47zTFBI04stLtyC5Bqn3_YQ7qL5zNW_7uOIXoYsficK9
 vcpGtBKc0c5NJKrDDP_sHk905peKownjP5OGrn_60W4AW_Y.eSc02AdynhAjeEkYz8gYJLNuNHXb
 n.QmUMSlsh9W3PklYJavEw6OmntugP.FHuR35tArQFhTEbz.B45SEaO_2Cbg82asPxi5ZhWGtKSV
 Ja2HI_a09ztV9WE0nwFAYwBqRmzCHdsyCBSeTu7L9yqQO9NCSRjkp53a3BhEJ.ezjc7l6MKehOIZ
 zPo0JbgADtvlDGi_gHR25iuIXQkbB9m.6ee_qBNeNR3M6GBENa9Y0C3SB.mPvOQ0HUAq4NR1RnJn
 mwYOipv0NeKnwxGxbXaxy1nQQQPeh1AnmytbOaPYsiZ3_oiSbF2yrEg9KXgFIiugAhbWCU2PnUHJ
 MNivcIxwEbzW935ntYkX.ic_.tbDpRsOFkb8JmRkWPof0z63cRJb9iKjed.ijGuY7HHljk2xhl6k
 lWhiyBfuEV2fNndT10IdAzxS__pqvtjennfNgv5lvxiEOdTCmYwnBVcPswbtKzLLKrzuVaeDOLh9
 Y.z7A384_8gMjtlHL7dY3cP36F8wx3uKdmSM.aoJFcPnC.qyhyiT5OXOO5WIkGIPjscUdWthTI.6
 IjtU94ar7NNJiTVBvITR1uiVCL_I2QH.0sE9ZsUM8isZvP07nSn2Gw6vynWHSHj5nxZfXpF.ygq5
 Ij6yjFsAAyS1STcSI4vOfPrDfgPVjt7Dhj7czGfrCPmvac8lXUiSFZ2wMUZcqbd2UzVEK.wmkPnb
 aK1B7c7ojTTvDabVkbOIpbjABY_HJ4UPsykDcIHmVPHiS1mr6QFTwtJoz1eF6c5A4DiDeOYbZJW2
 TLl2MP_zGYTDjTACDyCXNIxe2L4najZKWe4zHPy9tU_ATLsK.d5WLjyHuVR7sRlrWIGOKudNAc93
 6kyRVrANlunW.72Gow2DtrGw34mpzDnJs4Wl_ncSjW8Zi1ds3RRmOWO6tYSP8A3bes41WPGQXpy7
 xxRx8YVrM4lB1ZVkNVKX8TLMXdSk.w..qbGzEcqByD6DgK_S5TaAkBUe4hEu8_8uu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 26 Jun 2020 06:17:12 +0000
Date:   Fri, 26 Jun 2020 06:17:09 +0000 (UTC)
From:   FRANK <frank_nack_2020@aol.com>
Reply-To: frank_nack_2020@yahoo.com
Message-ID: <1513752212.2819432.1593152229939@mail.yahoo.com>
Subject: URGENT,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1513752212.2819432.1593152229939.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Dear Friend,

How are you today with your family, Hope fine? Please, it=E2=80=99s my grea=
t pleasure to contact you today. I am Mr. Frank Nack a banker by profession=
 from Burkina Faso. Please, I want our bank management to transfer an aband=
oned sum of (US$7.5M) into your bank account. This business is 100% risk fr=
ee.

Your share will be 40% while 60% for me. More details will be forwarded to =
you with copy of my bank working ID card, photos and direct phone number im=
mediately I receive your urgent response indicating your interest to handle=
 the business transaction with me.

1) Your Full Name.......................
2) Your Private Telephone Number........
3) Your Receiving Country............

Do reply me urgent with this email address (frank_nack_2020@yahoo.com), (OR=
 +226 51 81 51 94,) for quick spend

Yours Sincerely,
Best Regard.
Mr. Frank Nack
Tell; +226 51 81 51 94,
