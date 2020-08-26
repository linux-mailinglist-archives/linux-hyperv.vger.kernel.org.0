Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1E2524F5
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 03:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHZBMY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 21:12:24 -0400
Received: from sonic301-19.consmr.mail.sg3.yahoo.com ([106.10.242.82]:45581
        "EHLO sonic301-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbgHZBMX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 21:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598404341; bh=k6qD474V9VtXKDobcCBmjOJywgarZvgPlTt0r+34qBY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=lm523J3bq5fLh8Coi116EcyvAcjGxscY+/4+lfzAtuRa4lvtLZGCncjtvpQgkdQyEomFrajtXvG9QRfN3+OnQwHHMke/3g1JqHW/ie3DN1xKRfST+u7gY1ir9KxfE24i7n94n3Xjzfp34pWnQiEEKU2UTem4tnMZLGTGDfJX+grtDcddF1Vtf+tk+jn8qfeM4oJZ1DX/PHs3ugwjtVkgjlbOlZ+rCd8pN190K/1DY3zKeaCM9aWnNMboi+zsc6+o1DuL59Ys4mqouApn2w2UiCd9HEV5NPoO0chOmSbSWajHeOIb2Zxf9+996hM8dE2gDnP6u2rlg0cz2sgpq+laDQ==
X-YMail-OSG: L6njpf8VM1k26UA_MqwvwVajusthykNb.vkYFia6PB4f0YRK.vbEHcjcuL_9EGi
 d29U.sfkV2zLYcRovwD7Dnpaw_FQNemBx87fal2_pRI2Sa9ihkYFHKLKljs51VzJ3.QbWAiTpLVh
 TduI9eMPHRx2r2Ry63zjXDAYyPnE0Pqvq69zCXxhE5mmtUDZUFCOwdopLIuXh9eUPpeHP4JmaY8m
 UedcPh.9y2deZHI0huq6QYfD9qxdlsr8rE3rjG6uZfluIjmM4ICmUr.9.I7bWv_Sk7u3U9FPGUSu
 yoV92f.gu6srxtP2UKKlxSbO7Tbm1yH7ctGnxMbWuzgBq0OUflJTK2vxShBtcuDFR_1qCDIPYfKw
 6qLgy0X41DK9L2.RtnIjC1NCjrm1rlkrQBfqV8WfzS4LW8Kaq1JH8qkmUFehVGjGnk4vndCbEk1P
 i55ggPc.XCTQgpqiPOOrsADe6Gh1cwZZMlH89U9rH4jeEbCWpa1pkx.QTHyolSCM4JFyyBaUfHt9
 tmxLkeXSiB4Dq33TEpIskcV49tlkIlEFixJfA6W.0zqzdpr1wusDrst2ZGZ4t5HanljUbHe4NJUq
 AKwPtap971qHCmAHrjt4JOqcuzvbBUPvxQxRor69qsf0FCOqWYrNT_FC0Z15Bk3SRjJ_.tj.Ti54
 T5t5FX3.LfqEm5G_IEl2Rdh.CJVv7QBDY6dN3ahPhfY6mqBypxej9QdIhEF30ZloJ.BbYx_MKJzW
 RCen0nrO6aWR0PrXcbbky4f81J150XbxVf0dXtZRmSVSR47gxsAblonp0_Rn4OLDCe5uz4j4G5m5
 lGT970CoMtWwRxXAes3r5tsthyn0peXQFz2YpU8du8WUUoJhoq2SOZiIWzv4FCNUy3qDAOeG5N6k
 jSs6vh390ejhxUVaPTqovzQAJyEdvybet9OciD9OKa.GTSqNuKAy_Q3XZ2McqCJJRr9aJ9AIxuPK
 7Bu1AADM8Tp2Ly_03mTYmVA6lWrfr4voikAkgCs.fV2kHoqjnWeOkWG4y4wfrMMq8Z6TBBLJIuSl
 1eCNbSm6bMwiEBngy13aFgGqajgS3WCtRVIFfOlNixNuzVDvW9j6BMu7AFfndZo8TrbIESlweaIT
 g7u9BAAexPjW97rEdQ8bGetQ.uVqgShGqQEV9cN1YcgKLYB0mbR.9CteXKge8o177jMr4hnAgYKx
 tbyqPaJYdmEaAUE2LbBAmKOWbc6VlK6ANPy995oKj.iptc7T.Y3TAnwi8JcbIQtLbmNXFNt7Vx8f
 L2.iwTt31VILbSBkEki_U1sVtKdFGAksyqk1z_fxfHb_p8ZYGEHL4Uj_0usIgJV3fMWERrLlmaAf
 mdor1JiDYVVsK8jEVLCsEFTiJiOwf9n6JMgvIXUrBv4ViUdwxlLxRPa7JRLsR29Mw9.9gXXuM6Vj
 gc75rZBjuqNgLXkpHEMbE7Lvtc533RugTbgnH3O8sgHb8OTfEhek36tJiNcEdHe1sa.hPdTopXzW
 0Mk6yDg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Wed, 26 Aug 2020 01:12:21 +0000
Date:   Wed, 26 Aug 2020 00:52:18 +0000 (UTC)
From:   MONICA BROWN <monicabrown4098@gmail.com>
Reply-To: monicabrown4098@gmail.com
Message-ID: <1752460994.4234410.1598403138538@mail.yahoo.com>
Subject: FROM SERGEANT MONICA BROWN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1752460994.4234410.1598403138538.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I am Sergeant Monica Brown, originally from Lake Jackson Texas. I have 
personally conducted a special research on the internet and came across 
your information. I am writing you this mail from US Military Base Kabul 
Afghanistan. I have a secured business proposal for you. If you are 
interested in my private email (monicabrown4098@gmail.com), please contact me 
immediately for more information.
Thank you.







