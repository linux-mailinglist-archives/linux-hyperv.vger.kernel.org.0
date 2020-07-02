Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0321287F
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2020 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgGBPuZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Jul 2020 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGBPuZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Jul 2020 11:50:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC760C08C5C1;
        Thu,  2 Jul 2020 08:50:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so24506873edz.0;
        Thu, 02 Jul 2020 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3ZShXNghZu0mZy1xQ0pTk73q/Fxh7v+qQmyVwRa1do=;
        b=AunhPqqAXtWnBrOyRqiFufpbMgxXr9qPqoqCMUbxmDa4VI2+/cqFaWPuz1Y99enMWj
         YlxG+elVpU1x5fKV9AZCWiO49LwPO3wOUDDwA9gq6kGJoEGjel1kCzmW+k3nyC84Z4d+
         8sy7T2MS2BD0reyk1H8FEjXFj4JJ1Hgquf6CszlyZxZrCg2tB/t5uYt7zWbewyfoD29S
         0WkDzIbeAhDl7vI+TXVJuw/l2wxRXEd3j9rNplasBpMu2QuOffN6jbMVpq/5vBGAw4sM
         Rl02kl5AKVxk0YOS6FAcN39mnWusT0EjsiECZLfK296QDq3Kyil6Hj4Fc+F9Q32P1tqg
         HA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3ZShXNghZu0mZy1xQ0pTk73q/Fxh7v+qQmyVwRa1do=;
        b=qDXUZD3Ey4P/6mAIzN5BqzM4LlQPLrdzeaQ9Xc60WxDeMXKl2ikClQ84HZKi9rp9Ep
         6H3NbN6U89N5GCheV/VEBCmouqGq5e6bVmbn+5ul51jBW/vf2brrCPwBTFrKXoBOAdEY
         o4JYLtlhVkIAZiYNuDmTxy9U2+enfZAjMWZ/vl+P/l4hQd1gYtLkWpzuxNfkxOiQ4wif
         oic6UF6iB0mvtCwS1dUWijXJ2/hxvkfwF4qQM+Y3152OUm1yAPqUOyPvbeY4uPylYH+0
         vkRG7gZuZSezKHy6/DNeAYQApg6OT8C+sPp/Oux682HIS/s2qjIkDyE2ZtVB1KnbjILA
         dSKA==
X-Gm-Message-State: AOAM530BHbA+Xnhf9dgkLWfz9VKg9eU3PbOa7INY2Xvf5cTQPBK+YWAq
        lQ+2DXtcPwZB3STmNwQUYEo=
X-Google-Smtp-Source: ABdhPJwLo7zHrDUlriu5e2nB5mzEcjUuumr1wXReHao4hZcTbjaRaMne63Z0tvVKW8A56uDED3pX1A==
X-Received: by 2002:aa7:c98d:: with SMTP id c13mr26944146edt.188.1593705023418;
        Thu, 02 Jul 2020 08:50:23 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id s14sm9749761edq.36.2020.07.02.08.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:50:22 -0700 (PDT)
Date:   Thu, 2 Jul 2020 17:50:16 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     t-mabelt@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Andres Beltran <lkmlabelt@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200702155016.GA12759@andrea>
References: <20200701001221.2540-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701001221.2540-1-lkmlabelt@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Andres Beltran (3):
>   Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
>     hardening
>   scsi: storvsc: Use vmbus_requestor to generate transaction IDs for
>     VMBus hardening
>   hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
>     hardening

Confirming previous results,

Tested-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea
