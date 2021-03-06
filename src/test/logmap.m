rp = 1000:500:10000;
t1 = T(1:19,1); t2 = T(1:19,2); t3 = T(1:19,3);
plot(rp,t1,rp,t2,rp,t3);
ylabel('time(s)');
legend('CSBLM','CSBCM','CSBMM','Location','east');
xlabel('rp(iteration)');
title('Embedding time');
set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'TimeSpeedEmbedrp1000to10000','-dpdf','-r0');

t1 = tEnd(1:19,1); t2 = tEnd(1:19,2); t3 = tEnd(1:19,3);
plot(rp,t1,rp,t2,rp,t3);
ylabel('time(s)');
legend('CSBLM','CSBCM','CSBMM','Location','east');
xlabel('rp(iteration)');
title('Total time (embedding & extracting)');
set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'TimeSpeedTotalrp1000to10000','-dpdf','-r0');