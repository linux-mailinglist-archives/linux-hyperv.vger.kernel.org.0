Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEF3607FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Apr 2021 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhDOLJC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Apr 2021 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhDOLJC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Apr 2021 07:09:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47887C061574;
        Thu, 15 Apr 2021 04:08:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m3so27534920edv.5;
        Thu, 15 Apr 2021 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJEXGWtytFjUqt6P4vNA40mZIRxGMVPGV2UwUxWsXUE=;
        b=MaBpP8FijUA/2WCbs9DpH4APQkmy597fO4jiqpGIxC28kd06Y1u0erql2Bu/PXJpce
         kJAL5188+5D7BARP0IVigeF7tIQk6G2ZEgXvio2E6AEY8wjdUk00kAsvi/p0qIU6SGgT
         u5qWfeg3eoZarAbYGC3z81k4j7k4xHQKUMuBc9nCvvU9PxVOnbym2fWSOk1T2fUm28VP
         I7MaJH1NNceeUu7xY/Pul0TYZX7zy3VSvefXVG9N5g8HL9Q7dEjhenosP3u+X/EjoumV
         bQiwTtnQKe8tWsn57Ao0z73Cstezp+b3DlF1w0x/yQNhym645VyqJcJxMZEdXPgWCm2+
         QTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJEXGWtytFjUqt6P4vNA40mZIRxGMVPGV2UwUxWsXUE=;
        b=W32TBzoH6rKRu9EhZKPPmtocLIEwUXev6oQ0ZtnAqII5g8SWjh6V+3XOX4cPs8g0LD
         VMkvxyJZo7NM4ivHDr8Q/EQhMvw/i1WUTSOHg9Y92ueVzMOuqua5ItnT0bhXnYcfOI4Z
         zS8gFpMjZt+l3aW1HaJYutYnccKEjKf3gHLZiRrRC6jD/M0BgoZM4/2xWT8c2L9tI7zg
         ULWWHadOsf7Jzw1oRf3zC80kXKHiE5zz5Ev7lMPiICG37pG6Qr/0GSIgi9d6xwFcSF72
         wdLI6M/vIPLraQUstK3kuOFx32GySoJHS+hl716J6qgZ9btTJb0SqK0FQ02YfukKVpFs
         9u8w==
X-Gm-Message-State: AOAM533t+wVC1CmterNjjFMzA37gV0NTGVjJEIuiLwiDjReYemU5+hmi
        DJK08nTCi+9zs7//Xr1/f1c=
X-Google-Smtp-Source: ABdhPJyNyvR/OwJgW2GIrpZzpGlMdCvT5Z2rk+ivAL5XSbhytinqKJNhZdVesZtBIGEDuBO+XjMyIw==
X-Received: by 2002:aa7:c351:: with SMTP id j17mr3593597edr.199.1618484917913;
        Thu, 15 Apr 2021 04:08:37 -0700 (PDT)
Received: from anparri (mob-176-243-198-62.net.vodafone.it. [176.243.198.62])
        by smtp.gmail.com with ESMTPSA id o15sm1639244edv.72.2021.04.15.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:08:35 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:08:26 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus
 protocol version 5.3
Message-ID: <20210415110826.GA39379@anparri>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
 <20210414150118.2843-2-parri.andrea@gmail.com>
 <MWHPR21MB15935F8B28EFE3FAB8533F50D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15935F8B28EFE3FAB8533F50D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
> >   * 5 . 0  (Newer Windows 10)
> >   * 5 . 1  (Windows 10 RS4)
> >   * 5 . 2  (Windows Server 2019, RS5)
> > + * 5 . 3  (Windows Server 2021) // FIXME: use proper version number/name
> 
> The official name is now public information as "Windows Server 2022".

Thank you, I've updated the name and removed the FIXME.

  Andrea
